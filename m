Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D641C5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 756CB10E685;
	Mon, 10 Aug 2026 06:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="mO0UAWfR";
	dkim-atps=neutral
Received: from mail-244105.protonmail.ch (mail-244105.protonmail.ch
 [109.224.244.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 789C410E118
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 18:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1786127266; x=1786386466;
 bh=q4tdgJ5bQ15uNoWudEz5stteCUVUlugliOhQ72saDn4=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=mO0UAWfRmLjFYYrFgy52olWJr5A10Q+jJcQ7uoQPtexz7i3NfUwzGcShdTPrSTq7P
 xfz4+dRsNQoAxoUjBGmYvus4QbQKl+l7k1ehWle77qSz7V/zUOYiYJMM5t7aM5O+iu
 O6mW8BG/3fAyGac0BBJSncVuKQUDgyYcqvGsV3mSJRiRvW1lq62HdUZV1MQnBXQUsI
 3xD4mACBppEJ6sBBS8YPxUfDxKT9Zt3PdKSk0aVT7vettxKRjEIJrmah5vUbc/rvEf
 dT34lD7JWir4U0fmHYt+2LuhzEYf+UjDkixd/AaS5vcjftjP5MmdXNzUhkdiomBCVv
 wSGZWEPpF1tZQ==
Date: Fri, 07 Aug 2026 18:27:40 +0000
To: amd-gfx@lists.freedesktop.org
From: Satyajit Roy <edu042sjroy@proton.me>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, Ilya.Bakoulin@amd.com,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Fix BT2020 YCbCr limited range output CSC
Message-ID: <20260807182724.51018-1-edu042sjroy@proton.me>
Feedback-ID: 147615787:user:proton
X-Pm-Message-ID: ee450151c8c5bd5973580ddd300b54931e63ea7b
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Satyajit Roy <sroy14@alum.utk.edu>

COLOR_SPACE_2020_YCBCR_LIMITED and COLOR_SPACE_2020_YCBCR_FULL
currently select the same output CSC matrix. The matrix uses
full-amplitude BT2020 coefficients, so the limited-range output path
does not scale luma and chroma to their limited-range code ranges.

When the output is signaled as limited-range YCbCr, a sink that honors
the quantization range expands those values again. This produces
incorrect output levels and is particularly visible with PQ HDR.

On Navi33/DCN 3.2.1 over HDMI, the AVI InfoFrame advertises limited
range while the existing output CSC produces full-amplitude BT2020
YCbCr values. Using the limited-range matrix restores the expected
PQ HDR output levels.

Add a separate output CSC matrix for BT2020 YCbCr limited range. Scale
luma by 219/255 and chroma by 224/255 while retaining the appropriate
limited-range offsets. Keep the existing matrix unchanged for full
range.

Fixes: 07bc2dcbcf40 ("drm/amd/display: Fix BT2020 YCbCr limited/full range =
input")
Cc: stable@vger.kernel.org
Signed-off-by: Satyajit Roy <sroy14@alum.utk.edu>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c  | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/driver=
s/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 90d754d192f1..f264bb880aee 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -61,6 +61,7 @@ enum dc_color_space_type {
 =09COLOR_SPACE_YCBCR601_TYPE,
 =09COLOR_SPACE_YCBCR709_TYPE,
 =09COLOR_SPACE_YCBCR2020_TYPE,
+=09COLOR_SPACE_YCBCR2020_LIMITED_TYPE,
 =09COLOR_SPACE_YCBCR601_LIMITED_TYPE,
 =09COLOR_SPACE_YCBCR709_LIMITED_TYPE,
 =09COLOR_SPACE_YCBCR709_BLACK_TYPE,
@@ -116,6 +117,10 @@ static const struct out_csc_color_matrix_type output_c=
sc_matrix[] =3D {
 =09=09{ 0x1000, 0xF149, 0xFEB7, 0x1004,
 =09=09  0x0868, 0x15B2, 0x01E6, 0x201,
 =09=09  0xFB88, 0xF478, 0x1000, 0x1004} },
+=09{ COLOR_SPACE_YCBCR2020_LIMITED_TYPE,
+=09=09{ 0x0E0E, 0xF313, 0xFEDF, 0x1004,
+=09=09  0x0738, 0x12A2, 0x01A1, 0x0201,
+=09=09  0xFC13, 0xF5DF, 0x0E0E, 0x1004} },
 =09{ COLOR_SPACE_YCBCR709_BLACK_TYPE,
 =09=09{ 0x0000, 0x0000, 0x0000, 0x1000,
 =09=09  0x0000, 0x0000, 0x0000, 0x0200,
@@ -186,7 +191,16 @@ static bool is_ycbcr2020_type(
 {
 =09bool ret =3D false;
=20
-=09if (color_space =3D=3D COLOR_SPACE_2020_YCBCR_LIMITED || color_space =
=3D=3D COLOR_SPACE_2020_YCBCR_FULL)
+=09if (color_space =3D=3D COLOR_SPACE_2020_YCBCR_FULL)
+=09=09ret =3D true;
+=09return ret;
+}
+
+static bool is_ycbcr2020_limited_type(enum dc_color_space color_space)
+{
+=09bool ret =3D false;
+
+=09if (color_space =3D=3D COLOR_SPACE_2020_YCBCR_LIMITED)
 =09=09ret =3D true;
 =09return ret;
 }
@@ -217,6 +231,8 @@ static enum dc_color_space_type get_color_space_type(en=
um dc_color_space color_s
 =09=09type =3D COLOR_SPACE_YCBCR601_LIMITED_TYPE;
 =09else if (is_ycbcr709_limited_type(color_space))
 =09=09type =3D COLOR_SPACE_YCBCR709_LIMITED_TYPE;
+=09else if (is_ycbcr2020_limited_type(color_space))
+=09=09type =3D COLOR_SPACE_YCBCR2020_LIMITED_TYPE;
 =09else if (is_ycbcr2020_type(color_space))
 =09=09type =3D COLOR_SPACE_YCBCR2020_TYPE;
 =09else if (color_space =3D=3D COLOR_SPACE_YCBCR709)
--=20
2.53.0



Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E361606A32F
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=SN5R+K4C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2D2610FE35;
	Wed, 18 Nov 2026 16:08:04 +0000 (UTC)
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch
 [109.224.244.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1593110E0F6
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 16:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1795018075; x=1795277275;
 bh=ybEJ7XjfVIDnUvD/Qb4PwTcaWZ4aLDPGfn9w8FIN+mQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=SN5R+K4CSOKV3HVq+kcutTcUfZW40LnoOJf/K35SOPiHy8q3/ltb4UKsFk6BmBZ4B
 uiwNG/3gPYrd01y2JMps5iCzM8+QC4Hn8TSwoqP+yCEgWA+RAjE9WBdsD0WhyYDuNU
 wwFC8jvVQeWv5DV8mUS4tFSO+b1NBI8VrmmHVbAkZT1cX0gGwsNIBw+3U9p8cKFvD7
 3lJzsqsaVa5iILMyYRL/RAa6UdYPTs7QgZvDMXebfYdbvIlaZrmcgwNNslwz/j0zvQ
 142J2QX1hYOnBR2pkd5LgMdrgZNFkCY0NWYWl7OPNJNDvlBq906LLjlq5+NDzSF0XU
 9nECyRu8AjQNw==
Date: Wed, 18 Nov 2026 16:07:51 +0000
To: Mario Limonciello <superm1@kernel.org>
From: =?utf-8?Q?Eren_=C3=96zen?= <erenozen@protonmail.com>
Cc: simonit.orig@gmail.com, Richard Hughes <richard@hughsie.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org,
 Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/amd/display: Route connector DDC over AUX for
 native DP sinks
Message-ID: <0TqebV7r6TwuSRlaon2zTcY7N7UqY3fhGl1WDQ7U9iw4c_dTzijuuXkEWxUWSCqk2U-Rx7j_vjaXfaKNu0ohsM7esirKVbIOeLrsiuYMsOc=@protonmail.com>
In-Reply-To: <5386db0f-e9b3-4c62-bb2b-392cca4d761a@kernel.org>
References: <20261103-superm1-amdgpu-ddc-v2-1-7bde6d004382@kernel.org>
 <20261115082042.1902826-1-Wayne.Lin@amd.com>
 <c6d79680-1fd2-4e71-9d00-616010b7727c@kernel.org>
 <QU464501lRPW3X8es-jXBFOvvwqS3eKR3HRS33U6x6o5eYC6h5AKV7f3ZXRCaU7-sEcupJMHereqyDUsUSG_fsOMNwvGO_CcZRKsz1AgObk=@protonmail.com>
 <5386db0f-e9b3-4c62-bb2b-392cca4d761a@kernel.org>
Feedback-ID: 19860221:user:proton
X-Pm-Message-ID: 173af0e62a884fa30f1323a819f3d01a007a7625
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mario,

Thanks,  the patch is below.=20

With v3's ddc_service->link check the test passes even without this
change, so in v4 it only makes the test set up the adapter the way the
driver does. I tested it on amd-staging-drm-next 8dd68a79583a, which has
v2: the three i2c_xfer tests pass and the suite runs to the end again.
The one remaining failure, dm_test_fs_caps_dp_vsdb_version, is the
dropped FreeSync hunk I reported on Cooper's thread.

One thing for v4: if it keeps routing on link->aux_mode, the DP++ case
from my last mail still applies. Simon's testing probably won't hit it
unless he swaps a native DP monitor for a passive DP++ HDMI adapter on
the same port.

Thanks,
Eren

-- >8 --
Subject: drm/amd/display: Give the no-DDC-pin i2c_xfer test a dc_link

Since commit 48b8c06b05ad ("drm/amd/display: Route connector DDC over
AUX for native DP sinks"), amdgpu_dm_i2c_xfer() reads
ddc_service->link for every non-OEM adapter before it checks for a DDC
pin. dm_test_i2c_xfer_no_ddc_pin() builds a ddc_service without a link,
so the test now dereferences a NULL pointer and panics the UML kernel.
Only 670 of the 1931 amdgpu_dm tests run.

The driver itself never creates a non-OEM adapter without a link:
amdgpu_dm_create_i2c() already dereferences it. So fix the test rather
than the driver and give the ddc_service a zeroed dc_link.

With this change the three i2c_xfer tests pass again and the suite runs
to the end.

Fixes: 48b8c06b05ad ("drm/amd/display: Route connector DDC over AUX for nat=
ive DP sinks")
Link: https://lore.kernel.org/all/sashiko-outbox-195461@kernel.org/
Link: https://lore.kernel.org/all/5386db0f-e9b3-4c62-bb2b-392cca4d761a@kern=
el.org/
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Eren =C3=96zen <erenozen@protonmail.com>
---
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c  | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connecto=
r_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_=
test.c
index 33082a674d9e..87dc722715dc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.=
c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.=
c
@@ -6455,7 +6455,9 @@ static void dm_test_i2c_func_returns_flags(struct kun=
it *test)
  * @test: The KUnit test context
  *
  * When the backing ddc_service has no ddc_pin the transfer bails out earl=
y
- * with -EIO before touching the message buffers or the dc handle.
+ * with -EIO before touching the message buffers or the dc handle. Non-OEM
+ * adapters always have a link, so the test gives the ddc_service a zeroed
+ * one.
  */
 static void dm_test_i2c_xfer_no_ddc_pin(struct kunit *test)
 {
@@ -6466,6 +6468,8 @@ static void dm_test_i2c_xfer_no_ddc_pin(struct kunit =
*test)
 =09KUNIT_ASSERT_NOT_NULL(test, i2c);
 =09ddc =3D kunit_kzalloc(test, sizeof(*ddc), GFP_KERNEL);
 =09KUNIT_ASSERT_NOT_NULL(test, ddc);
+=09ddc->link =3D kunit_kzalloc(test, sizeof(*ddc->link), GFP_KERNEL);
+=09KUNIT_ASSERT_NOT_NULL(test, ddc->link);
=20
 =09i2c->ddc_service =3D ddc;
 =09i2c_set_adapdata(&i2c->base, i2c);


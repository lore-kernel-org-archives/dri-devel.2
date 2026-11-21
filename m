Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD748606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hTkD6fSF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8263110E608;
	Sun, 22 Nov 2026 17:13:44 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD7CA10E1D5
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 04:14:36 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-38564b4b017so1561460eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 20:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795234476; x=1795839276; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g0XEzBGmvwOkW39Vxp4j0TIiOhGg5iVLxt1dqiFm15c=;
 b=hTkD6fSFHnLcWNXzKVwX4Izort11K/b5X3t7hbBO4ZgBZED5216eQbZuApvAKlQjH8
 TiY9P6fUBFAcaYCRnncth1THVvjyp/wXIY0Re2AxuuttipU66UJfAGQ47tMLRr3cULaO
 B9YsNiucju6+PJCz9hSPEVs8fMuvGv7qIsyOkGD7JdsiBMiwYPJsIi9fqq6+l3w9okkg
 FpI1H5b89KCfxwjUwP3Bb4W/joNUwNxgvsID87VTnwhbF7oGGAvtJKUzPn6x1d6Z0dPX
 dpxKMZid/6wI9q9f9w0D1ZMqTnXmEHgT+7vODddjoOEBT5kNR1wjZ8KubR8kX2Rhem6e
 yIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795234476; x=1795839276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=g0XEzBGmvwOkW39Vxp4j0TIiOhGg5iVLxt1dqiFm15c=;
 b=k+rZe9Cy26pwg2AxHukMDRzsm0sxCPoAhKU5R8LPCssK7nTiIaa9AMTXfCkKvGcQGC
 PyQd5WqS178VRby/Am7wJ12VLunrYm0V7H+jRPJYLpnMztpkaWmfA2tO1/VDUog4c9pr
 smIk3/gLpl8cYnTgWrXA5gYoex1Vau0/Hl5O8NPUrRZxjtzkQG/ofjhNkoK2HYTc2XL/
 VIeryJkJge3R8JrFgYYeM7Sgc07iY7PhawUKt3FRI+QdGGgOdPIUAwk8tlZWZ6OwFWOi
 7s/+PM//2gLzpMmz3EMCRHjL6YVI1tRnZFr/hBcxFVM9I3zbFmKlTtTG59N6vbWVTtI7
 eEUA==
X-Forwarded-Encrypted: i=1;
 AL+hErFbYNAO4v6NSBSuP22YLUiHoCLq5q+HpleOvmpa1tr/mcP+8AhT+JnuzmJBzqYqqa0/vvA6/fl4gCs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z853U1NJC0F/jqvhMfRTV1kZzOql1WH18oFw4Jon9IIcN7bERBq
 IeXJq3Dp2wkY4iYvrPPFCz+diph++svyR5ab84q2asVsHY2NE6XQR9pS
X-Gm-Gg: AZFdTZccwr82l8CK3CHG1sXwx02yZgzTb+MQVHocmW1gLqaQ/Zh/f97ruZx7N0x/kn1
 O8fna1zZJJw6A9XLWwNBCD8FkfA8BwCmel8sV35AVNAklq8Cvo/yW7naFI3lEe6h/9l6/kQxemq
 6HKpIYeSwKPC3FJ5d6U1Hhk/xrOhcYt2bE+jGzyShwwnVr69+ELmt8HU1S3gKd7xyZXRywDBwNJ
 CdBXX3U4JFNogCtdQDP1UBiQv3wQfiogxylqR/hvoX011z1T88IjeIhj/Qvwm2prB8q3XVeSPJl
 psNgbkgn5gEPrEklwiuBww2y1ddOXKgEn/4g66YNlybA+YKhmiB4hA7Q8HlVh0bat9kTm1tBSzh
 n0b60sBoaXGv3V1ItLBypCfH9mQXzrdsthcBLlZAWGra3w64E7KiRfIJd2kJ/6bkX04WxQw9hWN
 ce0vR3npa+L368NMs3tszL73y1/wQBRCfy8ClttG4pyry/fEaQHCYbwAZJlIYcs1L20IDbUODis
 nDIMoXOGItUGXBzlpJwsXLSc1J7zcHIy0qQ19G1lsquX+O8nxiL+acq5J4T9nlhMWfMXB/DnA4N
 m1P1ItQVG2LsCDKYOl4H
X-Received: by 2002:a05:7022:5f0b:b0:196:b805:9546 with SMTP id
 a92af1059eb24-1b5568c4890mr4499639c88.10.1795234475899; 
 Fri, 20 Nov 2026 20:14:35 -0800 (PST)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5566c1142sm10379603c88.2.2026.11.20.20.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 20:14:35 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Thomas Huth <thuth@redhat.com>, Weijie Yuan <wy@wyuan.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH 2/2] drm/amd/display: Document max_gamut_remap_coeff
Date: Sat, 21 Nov 2026 04:14:27 +0000
Message-ID: <20261121041427.1743954-2-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121041427.1743954-1-takano32@gmail.com>
References: <20261121041427.1743954-1-takano32@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 22 Nov 2026 17:13:42 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kernel-doc reports:

  dc.h:329 struct member 'max_gamut_remap_coeff' not described in
  'mpc_color_caps'

The 17 resource files that set dc->caps.color.mpc.gamut_remap to 1 also
set the member to dc_fixpt_from_fraction(S3D12_MAX, DIVIDER); the other
ten leave it at zero, and the comment of mpc_color_caps does not mention
it.  Describe it.

Written with Hermes Agent, an LLM assistant; the author reviewed it and
ran kernel-doc on the file with and without the change.

Fixes: 1c5e6cd8291f ("drm/amd/display: adjust floating point format for gamut remap when needed")
Link: https://lore.kernel.org/all/ec4d7cff-d23a-46d1-b245-921f442b9a7b@redhat.com/
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index debdd69bbe4e..32bf87fed40d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -314,6 +314,7 @@ struct lut3d_caps {
  * @mcm_3d_lut_caps: HW support cap for MCM LUT memory
  * @rmcm_3d_lut_caps: HW support cap for RMCM LUT memory
  * @preblend: whether color manager supports preblend with MPC
+ * @max_gamut_remap_coeff: largest gamut remap coefficient the MPC supports
  */
 struct mpc_color_caps {
 	uint16_t gamut_remap : 1;
-- 
2.53.0


Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BE7C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B688B10F8FF;
	Fri, 25 Sep 2026 07:30:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jZp5tfxw";
	dkim-atps=neutral
Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com
 [74.125.229.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A8DC10E1F3
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 21:05:37 +0000 (UTC)
Received: by mail-dl2-f12.google.com with SMTP id
 a92af1059eb24-142dd04f7f2so289051c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 14:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790283937; x=1790888737; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ygf2sIU3P70RHHO5gUQG27kuSw6D0dXOtQSK/jAHxSw=;
 b=jZp5tfxwT7p0Cpyyr/EilaXo+jWFtQ0bJVJbZVT+9SwZO4CG1HkPA9lQ4CB57zo1We
 v21i0yxtkG8RA1EMDX6ytKdT7iFCSZ1Qka66tu1eTW3ezVVrfZH4WAlIJOfjaymWSwXi
 NnyM/4dqP3rAR5OOeCvBW3ZXu0b4K6zX3XXAn5onwAHd3+iuS9G9IrnpfkA6XsAcN/pN
 ZVsJKiDldq/GfIrqPKliSwiQCRjz+/lAizjjnobJEMh7DYhlVGV/sRyH2vutak1qI0vE
 L47Qu9jl5L4q5tno/ZBt2XLB/zQR+jzm01JCKGJE3g6S3aovH+dOORePyS2fvJUtiAYn
 h8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790283937; x=1790888737;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ygf2sIU3P70RHHO5gUQG27kuSw6D0dXOtQSK/jAHxSw=;
 b=qu6uXhtJHDYxvYDhh47BOgIYbrdaT/lTJe6i5ztaknkPFyTFufUHMTLnePtdGS5rxI
 x83gMCRfEYM7aCLjRPb7pJb2ngih4gLx+sa9HtzTnu4wziV833UlduR8ISI/eErZizWg
 wHj3SMooGF2mP6TMe1Nl0pRdvBMqPzt7yIRAO/NJuzSVTt+6s8w96p0TsYXgBayMYepO
 jA6UoN9izrNHrwY7230CvRZqVAXCcofSErzrhRmnJnU+Je/ZYGtMP8094avZ6Hu0TdNT
 XPbn43VTzZoaa9w6wOEY4FtILZTK2ZU5ttNr+Wy9q215fQhOG8rV5plBvir6bMHof+CT
 EsDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxKCShHOAK/VTPjGRDnSqsD8wm5hX0uM9DAfrVv4BlPMQy10N2KTepOMe+7muzwFNnpDu2Jac0m38k=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k9HE0DiiNE5RcKCR57EwPottX5T5v4qKAS4b+YkwTw7u7QXNnr
 gYtY5rF+iGNamfkaBlzXaAQc/qV9dkqHfccb8SR+y6BElDv0EDkirjWJTsw3FIr5
X-Gm-Gg: AYBFou2YIrh4bC6W45BxyG/benKVVVth+0N3vbgsyTeH9T3FG9VXsjalCfRgbiwYi/V
 ZGEPsu1oTj6rdhWQEWT3X2V4cku/fvupgw5fnglOyaRVVgRWzbUhiGdsUMyqsq/kS4BHZGcUw6h
 EnBRaeL52Ez6L89Q1TlyDrL4V6YUcH6U+VCQkq2f4KFQxh/O6wWnTEPYHNDqH9LBlDP/K6Ht+pC
 AknmeaOmcNE6GJblXO7PGQuzgf0rHTxGMedMYdlNr5APg/JIPHzlqutWQw2mVng/Uh+qdN6v7E/
 Qy2DmG5FOYmTttmBEumsPQIBAulHTtQEoQP+ITvTtqH+YYbcc5ESL3SvxD3LPL4Lv5Ggg+FDvts
 D9JgJNl+e68pZd2hdzvZmGN6SA/ic8dCtAvxEIDHcvTRhEV/a/U4CqNmwujMSvUuMQaCR2a9qeY
 P3vgaRZQegfQ9EH9b+RexKMqDpRUS8+5Vs7fwuSSQZN+4126qRy+8QCNaZiTg8J7HAC1aI+O+MO
 acc/UIq
X-Received: by 2002:a05:7022:5f01:b0:144:ee1e:3758 with SMTP id
 a92af1059eb24-14503f06535mr2466324c88.10.1790283935346; 
 Thu, 24 Sep 2026 14:05:35 -0700 (PDT)
Received: from maclinux ([2803:c600:9110:8ba5:43a9:9b8b:ebdc:6411])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145aa0cb6b9sm1016034c88.1.2026.09.24.14.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 14:05:34 -0700 (PDT)
From: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?=
 <fbeltranmillalen@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/amdgpu: reset VI ASIC on MacBookPro14,3
Date: Thu, 24 Sep 2026 18:05:23 -0300
Message-ID: <20260924210523.13214-1-fbeltranmillalen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CADnq5_PsKKiOXPuH9c8n0u8viyg0u3rTeDnPoeDBk11MP4V_hg@mail.gmail.com>
References: <CADnq5_PsKKiOXPuH9c8n0u8viyg0u3rTeDnPoeDBk11MP4V_hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
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

On a MacBookPro14,3 with a Radeon Pro 555 (Polaris11), the framebuffer
is at MC address 0 when amdgpu loads after a cold boot, as the firmware
leaves it (MC_VM_FB_LOCATION = 0x007f0000), while the VBIOS ASIC_Init
table places it at 0xF4_0000_0000 (0xf47ff400).  amdgpu reads the
location once, at init, so after a re-POST (S3 resume or GPU reset)
the framebuffer has moved and the driver keeps programming the old
one: the SMU is handed a table that was never written and the GPU
does not come back, which leaves the internal panel black.

Resetting the ASIC on load makes ASIC_Init run before the driver reads
the location, so the driver uses the VBIOS placement from the start and
every later re-POST puts the framebuffer back where it already is.

Add the Radeon Pro 555 used in this machine to the existing VI reset
quirk table.

Tested on a MacBookPro14,3 on 6.18.49 with the quirk table backported
(the kernel also carries unrelated local PCI and ACPI patches for this
machine).  The framebuffer is at 0x000000F400000000 after both cold and
warm boot, and the GPU survived 9 S3 cycles (lid close and rtcwake, one
of them with the lid closed for about 7.5 minutes and a USB-C disk
attached), each followed by a few minutes of 3D load; no ring timeouts
or VM faults were reported.  The reset adds about 0.23 s to amdgpu init.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Link: https://lore.kernel.org/all/20260924132952.25054-1-fbeltranmillalen@gmail.com/
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Francisco Beltrán Millalén <fbeltranmillalen@gmail.com>
---
v2: new approach, as suggested by Christian and Alex: instead of
    rewriting MC_VM_FB_LOCATION after every re-POST in gmc_v8_0
    (v1, withdrawn), reset the ASIC on load through the existing
    vi_reset_quirks table.
v1: https://lore.kernel.org/all/20260924132952.25054-1-fbeltranmillalen@gmail.com/

 drivers/gpu/drm/amd/amdgpu/vi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 2cd6d7d77..a0435fd55 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1397,6 +1397,7 @@ struct vi_reset_quirk {
 static const struct vi_reset_quirk vi_reset_quirks[] = {
 	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x0190, 0xe3 }, /* Radeon Pro 555X */
 	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x018f, 0xc2 }, /* Radeon Pro 560X */
+	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x017a, 0xc7 }, /* Radeon Pro 555 */
 };
 
 static bool vi_need_reset_on_init(struct amdgpu_device *adev)
-- 
2.55.0

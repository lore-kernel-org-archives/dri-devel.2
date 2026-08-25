Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECF7C61DC7
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:36:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 780458920D;
	Tue, 25 Aug 2026 14:35:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="GBikoIL3";
	dkim-atps=neutral
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com
 [162.62.57.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF60C10E996;
 Tue, 25 Aug 2026 09:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1787650194; bh=PWLKdWWaI2jPcx8YxTfUdYf0ELiUgEUH09VaKGicck8=;
 h=Date:To:Cc:From:Subject;
 b=GBikoIL359c92Lh0WaAb65RTefAqadljnBY6ohQobCvVF2hSnPBwS6iZP0C88fTLy
 aKjcu3gQDcNHe+XwjZTB+PYSlIpsr4/dvWxWjF8cV9cHnCaOecCnQSwrx7IfCdH1nn
 izRZm2fTdAusvnDeug6g4rVCmjTbaKuyFsT0fFwc=
Received: from [192.168.255.10] ([111.206.96.146])
 by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
 id 7733AAF9; Tue, 25 Aug 2026 17:29:51 +0800
X-QQ-mid: xmsmtpt1787650191tphskq0w8
Message-ID: <tencent_FA0B5EEC37B4CAFBE12C77A63D352E5BDD05@qq.com>
X-QQ-XMAILINFO: MMvVzQSdFuTppb02eZXtT0Vrl27MwY8Z9fPbj6GlfNDU9Ya1D7PLeQW1FgLyYS
 mtupIQ+PjAuGe+RBAk/E0cP9kqOdT8+SV0oVGck4wV0R7w3D8jiw2KbZ+To/CkTX77YqE7vJJJEL
 4YPZSlYGdc+Cjf8mr95yJctLz74qfad64uPuJI9fN/HLS784JBMltOmET3ioepwpqYq6EHPqHREK
 s/5aZJWmxBn7pp3UkPYmYYfhngCqQIvzr6pWt8zElE6vUV640OHqDemkXvEvvjt89erhNePsKUlB
 m3y0N8kzCZEZfoCkPpZwkMeD9hmisCKQo4gIhw320hptDsWLal1mRz4qkW33beEwmIMCrfRFWKDK
 HXpgU4rH0OV3A9ndBYyzod7E38xWv8aKVkji9o6WNfDattrHtI1M0sfH3I4RmeImm2Sd7gNQPHHw
 j/9XlDOj1bcTGj2VuqpmbR3n8SR/7Tn0LBA9IcLCVbM5wQ1kcaWgQ0LLUqikBSYR2XYH9coEfyer
 LEJYzriq4Te74NX+oqrcBx/Zx7Y6x72vw7J6SwMsWMBG4d0AqhD4LiJYp78eh4yJwwVIhYqzzBrD
 2uSttOiuqq4BNzZa3jOdUwKcfiN169GwnSY7yJI69hloICYFsIPBx2pFRdN4O7essyZ1kzICUf9F
 DGHm0QagRAsfO7FLyLtC0+QxXVktgZETHPEZmj3FoNW2FmzM5BOHWsRC1+5V6wTL3YJHw66/DXMM
 FkBWOV1r4dcSvEfxqqx1ED/1OMx1fYOiCsEW3295/ygsHJOZzzib8iEvOMbg3a6LhMaDnUOGJXEE
 DOJ+fDEdVIuK3xjB6hd2Owomt9nXuAcOOfgAOBo56xJ0OvDPYyK4f+lsIq7QAv0KknwrxcMHeKyQ
 TYWIkiqdhBOVvKFHmaIoJHgkouCDfXb9TcerkZLoyXUXdShtEUEYza+3Yj1M5isuPI7iPqL45N4z
 xhTtllDngC0+g2HBbRGlW9sdg/jUYbE+A9nrJNKbWU0ycAoUkUvPFobC49frBtXvpfmDIKLsZgsW
 lzELxFKf9tpKpJaqAPNvnmY/GPn+mlsr+ztpnT6U3tXDD9ijJ4GkeQ1OKIH5rp5Ez8QQi0W/iCk2
 3jkTO18Jni9UfwtEwEN4y/wmu8fzO/CWLaTRkuj0lci5z9VEg=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-OQ-MSGID: <0ae2d2a2-8c16-43e0-bdf0-5e9d3ff99e46@qq.com>
Date: Tue, 25 Aug 2026 17:29:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: alexander.deucher@amd.com, christian.koenig@amd.com
Cc: airlied@gmail.com, Simona Vetter <simona@ffwll.ch>,
 Sunil Khatri <sunil.khatri@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Natalie Vock <nat@pixelcluster.dev>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From: Yang Zi <2959243019@qq.com>
Subject: [PATCH] drm/amdgpu: fix NULL pointer dereference in amdgpu_vm_init
 error path
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Aug 2026 14:35:48 +0000
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

In amdgpu_vm_init(), the error_free_root cleanup label runs
amdgpu_vm_pt_free_root() before amdgpu_bo_unreserve(). However,
amdgpu_vm_pt_free_root() walks the page table tree and frees each
entry via amdgpu_vm_pt_free(), which calls amdgpu_bo_unref() on the
root BO and clears vm->root.bo to NULL. The subsequent
amdgpu_bo_unreserve(vm->root.bo) then dereferences a NULL pointer.

Swap the two statements so that the root BO is unreserved before it is
freed. This mirrors the success path at the end of the function, which
unreserves before releasing its reference.

Found by static analysis of the error handling path; the failure cases
(dma_resv_reserve_fences() or amdgpu_vm_pt_clear() returning an error)
trigger this path.

Signed-off-by: Yang Zi <2959243019@qq.com>
---
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index d2ad5b0e8759..dc72181ea0fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2672,8 +2672,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
     return 0;
 
 error_free_root:
-    amdgpu_vm_pt_free_root(adev, vm);
     amdgpu_bo_unreserve(vm->root.bo);
+    amdgpu_vm_pt_free_root(adev, vm);
     amdgpu_bo_unref(&root_bo);
 
 error_free_delayed:


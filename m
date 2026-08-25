Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9891AC61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8B1989444;
	Tue, 25 Aug 2026 14:36:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="aRyBXA5+";
	dkim-atps=neutral
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com
 [203.205.221.236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0B7B10E99E
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 09:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1787650584; bh=PWLKdWWaI2jPcx8YxTfUdYf0ELiUgEUH09VaKGicck8=;
 h=Date:To:Cc:From:Subject;
 b=aRyBXA5+SesmwQvqClu0bZ+zoszcSFaBpdwhzuq2j3XOmwGzfjr71xbozbKYDkr6l
 rrFlzgJvwLGcGoInLv2cOoX5jCN73Wc0TiisT6h2QZcrdZqzlkzYgAfIaP8nIb6Kzl
 o65uERvWUS4RJMe6Jlgpl7zcic4XPRdwDFz9WNLc=
Received: from [192.168.255.10] ([111.206.96.150])
 by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
 id 915904B6; Tue, 25 Aug 2026 17:36:21 +0800
X-QQ-mid: xmsmtpt1787650581t9me5pmpc
Message-ID: <tencent_BA5E7F623BA1DDDE076775332AA916D99E08@qq.com>
X-QQ-XMAILINFO: MYIgjB+F6BG8a5PFzh2c4y/5sXd1dGtBj7Y+z8RLxwkXr08O7Um1KBPMs66PkP
 Ahoodn2jSdfQN/rcUbRk/Z/R1dSWISYPc0cw/mQWCGXyYmGJXgOhkcaV4mY2BPWjigLlsP3tLmNf
 dzZKP2DMWAjKzNPMK8zb/MuokyI6c0A6cVNLuQJNKpP0tX1sN62hvFSsMRbbu7h1+Hz5Kl8JRPHy
 VTSdgIE7IaGWJUM/A9lx32nZ9kq5/EjncxhOBvcbjZV60E8EcHIkXJSEBB0qWxKoIPOCsNIHmIry
 1IWmKjWg+kMuqIj4j1Ny2W7eDRbCpbsGeWQz8W4yDFZ6RfyveQPXwsqw+LUQxb05KQyp1icpv3dH
 1jDYjCpZ1m9cspbcEQ73EZYalTBjAoOLtwrQQ0kZM9PAG3ej5R1D2TmRsG0AZovEqoO1njkvTOfl
 wcNN3sjhLDfQdClLrbIzJRGLrZCNVSkSIC7SST81EX2xwsBTzP1GkkG+lAQsZ2KWDIjS8tCSI5aG
 XEb9ilg069VW007zKOY+fNWNTI1DS0aGdei+pyqCiDXbQ9WjMhaz8WVeuUU5b3VwN285j5XjLVH/
 IZk3AjMszXEUutTN2zJ0jazx6PknoYjPYr/VmiA7RnSxVV/tdwmZofffT+MpUTswVE9JMC8YjcBq
 9P+8ZUqRI4t86R6HgpQ63P8U8gtlO0S+AyJMWKbcf00jM+PVXxT8EDDHMwRrgpXdO9a0Mtg9KuGa
 YqZUbI6KKfU3XjV+WDxdRujOaiUA9TEnEYmU/HSwJIbyN0Sb31z2ojnUrBYIBafvXtAVgzGLse56
 FA+2UjiPVuyma/8w4dOg0Iw4Qfhg7l/T/vHCFEjH6mwWmnyowG6lr+XX9RkUx1oe1GkZ8tm+ZocL
 V9Okbjw6lQi0mx3QsGKvvSXSuZwYKgoWlDyclJKD6458BQ3zHmYA9hmu/Lzc4/eYUEeIWzmHxC0u
 qqrCyFs557uiVcrYzaWU1UyBCC4EUCxq0pKnLV2/Dsq8POoN0I2FRSukmIuOekVKVXbD1377YCQU
 KgZs5cZ2xKWiydtpWUAL6nMvZgAPqEKPGHu+ddZ5pDzem/hp3dn8UdnOHgoRhfFRzwxdlQmPsc3i
 zoHhqtQ5R7xOH0aKUKTGRaq6kT5Tj/ec3+oWVK1Kmzitc/Vswr4zKjFDw05g==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-OQ-MSGID: <43614503-2270-4aae-9d20-7dec42c6c7e7@qq.com>
Date: Tue, 25 Aug 2026 17:36:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: alexander.deucher@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
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


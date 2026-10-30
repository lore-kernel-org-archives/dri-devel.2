Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03324606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xrvMpkzQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2698A10E869;
	Fri, 30 Oct 2026 09:12:49 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 045A3112642
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 03:55:54 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-8b06c0794cfso2998407b3.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793332554; x=1793937354; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5zugQx4flv62Sdzk9Wl3acRuLP/zK3sGN6owEqXiGh0=;
 b=xrvMpkzQr80CH6QbH1KItV5qmkpGSxRMS/vzLiK64Qxi2SIqzWHfouje6f8bodEIap
 /HGUu/nfYQ2dQQg6vUSR4lLHn3N9jk8gNYFFDX5md5fmsD/Qud23QF2RY96sIFwuRw20
 dz/Iu2Ntwn9AJwB6ukhFOW5g9BufPKufQh3BnL4sv+5oGm5kqeoBcFByrLY3410zapqs
 lsbMRJuXAQ4BbJtrctKuu2mo0F6Le/puBIfQcyOZ5mknLG2OYUU0y0hBmLkhpOd8r4K7
 1lvTU56CL/usdtSJWfakIv4mM+i6wrV1nrTxKbRnnKM9aXzdkRKtlk0Vz3mDvkbj9huX
 /tzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793332554; x=1793937354;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5zugQx4flv62Sdzk9Wl3acRuLP/zK3sGN6owEqXiGh0=;
 b=HCqZEH/URfRIU774VD9lF1R9vk+mhVowV18ACu2QfgJrrdoFx49rz+RkBLXrlRBKeI
 s8Apj7XoFrLDAMHpj1JVuRYwmXYbHGIoXjjFSF2hiGPQcZexCBGHQz3QhVR8ehiLZoXF
 YFCmLctJJHPySM39rl+iA+gxPNk7z9MRK6wRqrUEjaih2jpXjtDwQShads7YCi0SbUuq
 JPb3+StrddshTOxwTmXKMGjW/j815XJLsjxfM3uk+V6HXzmstH7IT/mmls+0FeLRC5nx
 tUJQEMnDbmObC2hpNlfEbOfG8dk1iwvMH3TNELRWuAu9QSfTuyGtXs/36k84e5z5Lh3M
 lDTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1D5WH5x/5kXXC4B4lDLX9XB55MD9GkyM1lZ5gdVVuio20LeoOziAKtpoGSUR6LsR+3xuHO9sBeo8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJM1rU9wSTq/yAOLAeLAIDjKtIDS7pGsd77LRlg7RB1cQ0wHqZ9
 S25ab/qnJXRztRf4/6PikBuMyiepOSd+08dXe28rgZG1xjmME1ibyW8J
X-Gm-Gg: AYBFou0TA1/gEYyXBn6S/5wEbVpdK7zLJ4zwFposeAWtydybHfSsFPKvqjHXaOyL2vW
 QQ0BIQNJxACRSIYq7LJzuhcDYzYfKVq4DcSBKQfHHTbjJiOv2LMapXE3JQaUTrCaUGzj4pxEl0c
 PYtqOAeVZq/chk3tzNwflxrtRIWdCCwDTwxEP81oxzRvIqO/YVVZYoeSvmybGJkLA+/YFpXQXao
 LlwEBqJ4M2slUr0rHLlDvL+LHs9g8LoPBCFRhweFMtbfd/TchfcF+nc1BKOxnXI0w2Bo6x1ma4y
 imJPwo5p+MFCLOE/OVwaHrZ7WuCHDU7IxtWcd5mEcvFe3B8lUl+nRGtvfZmKnmAcm5FT0A7fG4M
 JvLnkdTcZHB9udwMeJAXM2Ps1G32jg8tDz0cjrXC9f/yCe8k/ixP2LNej3snwVjbyMpRT04lSrZ
 qk/+3bZstBRfdFFHtCQoLzhVBzBpkD4y3lVGaiGjJ3JRZFHCLAbcCAgLmHmwguKDVLjHQ/37/XD
 5kePomNn/vlv4qiEGk6TgzxmqXXUmW+f9bLbdgTwwp9mhnaE1dkQSFxpCtLzxgLee0PHUk3VuL1
 ctsXAWvNx+857KKMqHaMLJ0/Pxsd5emILQOauRGf8X3i6yDXuBZ9PMmZ5ROHKVlJTUHQuOGqzFs
 i1hkSF5ML26s=
X-Received: by 2002:a53:c08f:0:b0:679:b98d:9b65 with SMTP id
 956f58d0204a3-67ba4ff16damr696189d50.35.1793332553574; 
 Thu, 29 Oct 2026 20:55:53 -0700 (PDT)
Received: from KastenNixOS7700x.lan
 (h191.160.142.40.dynamic.ip.windstream.net. [40.142.160.191])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67ba73addf8sm309599d50.3.2026.10.29.20.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 20:55:53 -0700 (PDT)
From: Josh Kasten <jkasten@gmail.com>
To: calvin@wbinvd.org
Cc: Jerry.Zuo@amd.com, airlied@gmail.com, alex.hung@amd.com,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 aurabindo.pillai@amd.com, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, george.zhang@amd.com,
 harry.wentland@amd.com, linux-kernel@vger.kernel.org,
 mikhail.v.gavrilov@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, Josh Kasten <jkasten@gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: Allocate DCN32/1 dmub memory to
 GTT"
Date: Thu, 29 Oct 2026 23:54:18 -0400
Message-ID: <20261030035423.37193-1-jkasten@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <25995707c39c0c191e3ac46c4813f55a7f928403.1793131583.git.calvin@wbinvd.org>
References: <25995707c39c0c191e3ac46c4813f55a7f928403.1793131583.git.calvin@wbinvd.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 30 Oct 2026 09:12:47 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I am able to reproduce this issue on kernel 7.3 on the AMD RX 7900 XT GPU.
* XT is not a typo, however both XT & XTX variants are Navi 31 anyway.
Never seen this issue on 7.2.8, 7.2.11, or 6.18.54.

### Conditions to reproduce banding issue
#### 1. When sub-viewport (AKA SubVP) is enabled
Check if it is enabled with the following command:
`sudo sh -c 'head -v /sys/kernel/debug/dri/0000:*/amdgpu_dm_capabilities'`

I think the amdgpu driver is in control when SubVP is enabled. In my testing
with a single active display this gets enabled when at 4K and it's frequency
is 100hz to 120 hz, inclusive.
Mikhail Gavrilov gave me this description for additional conditions if SubVP
get enabled:
> On DCN 3.2, SubVP itself is limited to:

> * refresh below 120 Hz; or 120–175 Hz for 3840x2160, 3440x1440, 2560x1440
> and 1920x1080 without scaling, and then, on a single display, only with
> FreeSync off;
> * pixel rate up to 1800 MHz;
> * no overlay planes and no rotation.

#### 2. Memory clock changes
Make sure the video memory clocks are not locked as the banding only happens
when the GPU changes it's memory frequency when the frame is being outputted.

This happens more often if the GPU is mostly idle and you move a window or
resize it in a desktop environment like KDE. I see it as often as a few times
a second, but sometimes it takes up to 10 seconds of doing this.

#### 3. 10x more often if amdgpu overdrive is enabled
While I know AMD overdrive needs to be disabled before reporting a bug enabling
it will allow you to reproduce the bug more often and faster. When 
`amdgpu.ppfeaturemask=0xfffd7fff` is set I see this bug about 10x more often.

### Confirmed revert of a637a140 fully fixes this
I confirm on next-20261023 by reverting a637a140 I am no longer seeing this
issue.

The revert didn't go clean on kernel next-20261023, as there was some changes
on top, so attached is the patch I generated for the revert of commit a637a140.

### Summary

I don't understand the optimization done in commit a637a140, or if there is
another related commit that should also be reverted. However what I can say
is I haven't notice any side effects after running with this revert for a few
days so far. It might be worth considering reverting commit a637a140 in a 7.3.x
patch release until a new fix can be tested in next.

Hoping this gets resolved in a future kernel release soon, the banding gets
to me sometimes and won't want this happing on other AMD GPUs. :(
Let me know if I can help at all with any additional testing or information!

Signed-off-by: Josh Kasten <jkasten@gmail.com>
---
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -538,7 +538,6 @@ int dm_dmub_sw_init(struct amdgpu_device *adev)
 		DMUB_WINDOW_MEMORY_TYPE_FB,		/* DMUB_WINDOW_CURSOR_OFFLOAD */
 	};
 	int r;
-	int mem_domain = AMDGPU_GEM_DOMAIN_GTT;
 
 	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
 	case IP_VERSION(2, 1, 0):
@@ -675,19 +674,13 @@ int dm_dmub_sw_init(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	/* Limit to allocate dmub to GTT on DCN32/1
-	 * TODO: Other asics with GDDR7 may have worse latency
-	 */
-	if (dmub_asic != DMUB_ASIC_DCN32 &&
-	    dmub_asic != DMUB_ASIC_DCN321)
-		mem_domain |= AMDGPU_GEM_DOMAIN_VRAM;
-
 	/*
 	 * Allocate a framebuffer based on the total size of all the regions.
 	 * TODO: Move this into GART.
 	 */
 	r = dmub_bo_create_kernel(adev, region_info.fb_size, PAGE_SIZE,
-				  mem_domain,
+				  AMDGPU_GEM_DOMAIN_VRAM |
+				  AMDGPU_GEM_DOMAIN_GTT,
 				  &adev->dm.dmub_bo,
 				  &adev->dm.dmub_bo_gpu_addr,
 				  &adev->dm.dmub_bo_cpu_addr);
---

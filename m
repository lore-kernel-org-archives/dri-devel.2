Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07703606A325
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k344ZHXr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46C0410E874;
	Mon,  9 Nov 2026 09:31:10 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7111810E11E
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 23:06:38 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-cd6acc50b8dso3993a12.3
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 15:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794092798; x=1794697598; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:from:content-language
 :subject:cc:to:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UQnzYFxAOJKkpWtTfKgcH4cjgDxirCXKastrMn3uBO8=;
 b=k344ZHXreU9nECQaU2LzVCLKVDzXkRzk1mZpJ5v3Dbr4ecOE8NQBw4SQVMPOJswJ3a
 aDs5S4+XuQP/mrRGVq6CRTVPTrdFYnUTwCHaRPcKrC/u28zTFUjNpszGFZhBPfX9fu1a
 k8uoywDd7M6JBnirXRqaoZZZ2Ud33piOpPeWBDqn5FvccUZdJqExI+5a/wpEMlK3FeRo
 8sXmiwZYj4GT/qeTGKNT95cwXvYRWRH6nB/CfCWlxFM6g13B8+XL6lk/No+BzgeSCrFb
 ru6HTeKNjGGHf7dt9z6Evwxx3t7faXCXhh/aDwJWbFeJ1MwF2/KWu2wvG4UPwbqJR/U4
 10KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794092798; x=1794697598;
 h=content-transfer-encoding:content-type:from:content-language
 :subject:cc:to:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UQnzYFxAOJKkpWtTfKgcH4cjgDxirCXKastrMn3uBO8=;
 b=0ztpWHQC9frM/n1hc6A+HFUd58VK1XLW8VGIHD6qA7yNqWGlB3TkY//5uAk7xueaEs
 55Q4DIw9SqgWhj7DnsAGH8Qp+3Glnns8vdaikRyHVBjQe3KA/wfwzr2hjg4L2LLURh0/
 aOWIYqgSlsGxelWxuTCulVv2B9jN5UeQGk0C1g4hk2PBHkdB3NZ3d/P1YpcyiRYFdaxC
 pLLVo3zOaQsQtjNhi7L/PLcSgVCoSI13h67OXphtC0SpLK5PTzKE0PRLeZtFWx/MXKYW
 53JElAyFAmFimKutyxK1S0sicH+eOVpIvlT5hroIUqmVwslrbVir5NfRTXkZRZDHxK4g
 KYRQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHrHg0PaQn8yWn5dehzZBffvic6ic5ZV5PPRvOiKhqqUXcDTZv6VQAnJaJpHbnuMsMDiuJkcqNbzvo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9buYQ10a2Ip7a/3+ltHSvVSpH1xMeYIw1jp6giKE6RGQGekQTl
 JIDK6b64l7N/VGdtAHWjkfoYgLxcj0SLtE4o/rZNDFtdAhfz2xDw3A+aVKSYohgI
X-Gm-Gg: AYBFou1z2HsgBqev3mSswOrQtw7Ni+KdbrAAeK973Vd4fnwXdpVeQNIgkKbV02xYmCr
 qyAWXZWUuEdmDWHzN3k99ycKUH9gDL6ehtNiUJS87nt1duGIY+ma5CTlEIowmGzQF4BVYIfFXGA
 JDYPSXmah0goUtw7nFPEc3rzIagdhqiJk+r6HkpUeTOSePjUxVIcpJ4153bHCv8NbynRtycJXd9
 CRUdBIugthUBT/lMHJinzQLlnNf3uQEwHLNxTPqFQUYVqs5JJitHhBozTwrhGsHMYgt5JXiewsz
 X9d6gj949lJ+SlL6Bb3evw8CJbjEQiOi8Fy67DHmQxBrSXa4K7DikJpscglSWVzASLnm6rsN0gP
 I9JsHvg64/omqXFgJq3crR3hkV4XRYSBJa4JEHqkAFt0Oqd37G1F2kUECRHtkGquU1rXXlM5pK7
 C/PUXdYQFKkezU6lwKKocQETaDbGOIeP2fd4TnTCpS8q5e/UG9FzaJSW3zknHyI5WdwpydfaoY/
 AJs0fUHuT1vkJVKHucYzz0vlTHLHAMo7GECo7OzP42WpH9bWo7D1686EfROrkdke4RMANoUUoza
 xpEvPIgRvpUO2EYRPTIT9WBaKfxpku5AEwf4V7dKfBMtR7aRDKy63x4K7nl0oqWUKl74VCbiHGK
 FFZKbn5H32RKf/7PPqDSWTXe62qQ=
X-Received: by 2002:a17:90b:3eca:b0:3ae:2969:903f with SMTP id
 98e67ed59e1d1-3b0db70517amr6641261a91.45.1794092797901; 
 Sat, 07 Nov 2026 15:06:37 -0800 (PST)
Received: from ?IPV6:2001:569:7d38:200:979:7485:a7c:55d1?
 ([2001:569:7d38:200:979:7485:a7c:55d1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1058d3310sm4614213a91.15.2026.11.07.15.06.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Nov 2026 15:06:36 -0800 (PST)
Message-ID: <5fe58549-2d21-4ecd-b4a2-f02b1bb90e30@gmail.com>
Date: Sat, 7 Nov 2026 16:06:36 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/i915/fbdev: Preserve visible size when reusing BIOS fb
Content-Language: en-US
From: Zheyu Shen <arsdragonfly@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 09:31:09 +0000
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When reusing the BIOS framebuffer, intel_fbdev_driver_fbdev_probe()
overwrites sizes->fb_width and sizes->fb_height with the framebuffer's
dimensions. These become the visible fbdev resolution.

If the BIOS framebuffer is larger than the mode selected by the fbdev
client, fbcon consequently uses more rows and columns than are visible,
leaving console output outside the scanned-out area.

This occurs on a Broxton ZimaBlade 7700 with an MPI5001 panel connected
through DP-2 via PCON. The firmware provides a 1280x1024 framebuffer,
while i915 selects the panel's preferred 800x480 mode.

Keep the visible size requested by the fb helper. The larger BIOS
framebuffer is still reused, with its dimensions exposed through
xres_virtual and yres_virtual. This matches the fresh-allocation path,
which also preserves the requested visible size.

Boot-tested on the affected hardware: console output now displays
correctly while the virtual framebuffer remains 1280x1024.

Claude (claude-opus-5-5) assisted with patch preparation. Copilot assisted
with commit-message preparation, building, deployment, and validation.

Fixes: d978ef14456a ("drm/i915: Wrap the preallocated BIOS framebuffer and preserve for KMS fbcon v12")
Cc: stable@vger.kernel.org

Signed-off-by: Zheyu Shen <arsdragonfly@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_fbdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_fbdev.c b/drivers/gpu/drm/i915/display/intel_fbdev.c
index 219ee17de3f6..5c043172a35c 100644
--- a/drivers/gpu/drm/i915/display/intel_fbdev.c
+++ b/drivers/gpu/drm/i915/display/intel_fbdev.c
@@ -324,8 +324,6 @@ int intel_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	} else {
 		drm_dbg_kms(display->drm, "re-using BIOS fb\n");
 		prealloc = true;
-		sizes->fb_width = fb->base.width;
-		sizes->fb_height = fb->base.height;
 	}
 
 	obj = intel_fb_bo(&fb->base);
-- 
2.56.0


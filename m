Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45572606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p+OE1mp2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80608112E80;
	Fri,  6 Nov 2026 15:41:22 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6534A112E4F
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 15:41:16 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so439273f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 07:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793979675; x=1794584475; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iINQ7+66n8MyNBUO+hVUf8gbKLIXhMnouYLmNtUXHPY=;
 b=p+OE1mp2Q00fWoxJDJmkLZzrhRuCy7FILTsX4E/01Q2rW4tqhbIn/8NE3P9L6VRzQh
 cThyaCCsPogMsP0jzuLI4Jv73ByBOdbnYGcznll9AFkx/cqlQ9kZpnDqpptnNqRN+n+u
 oXVDaln29ne7y6JUTkgygcZwWYRCNM4Dl5vxF7oS0wuvvuUv5fyoSLbF/IMJRHlx/m2d
 0JC+iuwuBI4APRuX7R1UskR5yovCS5WU+qOlI2TuIFobXvs6hw7fkLFo2oF+ZU+aqjQV
 dUJ1mb4Sur+1WOjj2R0S9YGOgIdh62mdJsc+x7fEOka+vIW6T8zT2NsC9P8aNASu6p7F
 s2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793979675; x=1794584475;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iINQ7+66n8MyNBUO+hVUf8gbKLIXhMnouYLmNtUXHPY=;
 b=RWKxFpTUETnoHAbP7z+ODIYqNSeCjGvZBO/4K3JOHwKK/K4DbaAF+id2KSEkAt6KQS
 CnnmGlT4VyvyLkC9AoH/q51ppfLHVlshAZd4HnxpkEvKwbb8ijfq8Bueogv7/vJ0ebpD
 f3ZESOS/qycJ0qXH9YD8/ZKkoJcxavLYZYYiAoHDTqEAS5HSBAfX9wfT+4xq832tKo8r
 iaT2pfNhbfy+x4Dz/jKelvFpLe4bVS2T06qLFWGZ/Cz/duRQ2yRpZ8K2FM0Mt7PmEGK3
 JzGH9yLfFmHNq8R+mF3kTUu35AZU069nUC131vp5iWxbs89RmzbcPp7dReWuFI6hEHyT
 nE9Q==
X-Gm-Message-State: APuU4Z8Fci1QOb+abzQdrmJLr54Prq92HotqA+Z33QylVnFLE+Sz/6r9
 pUPAKklSYqa0y7BMxelro3YqC3/OGv2ctpdkRqgKsbYmgSUagXNsfsgb
X-Gm-Gg: AYBFou2Zl95cu2o8gdTIZIt+mBZ6HcG4PmnWWF6DRz1fivsyhEe4V9FeikVhnevtD+m
 yd6yh8frWkAhveXYG02IVrKFV3z/fb9zpt6bq7Y7EsMBekCVEEtCBYJSKj3VuMDs5/GUJIm6TTv
 qm4NZn6kj5otbAjszgr2TVtJn4sqg1feTP89ne/1mA/4iktGlG7/LXF2UIdDp5XXNMOjdVFm+N3
 MCOAXaCTmonSGlreWqK4BmUHrapeXjHwMnuYlRsiu+2PTRsyE6fcDu3RCGDAzjdD3KGYvdH/rPx
 LfUlRFzhltsrQM0OBCD5TAYjbARqmcvbgubgwsGRG+CFXrCGrnvaYP6N6J/u+CDDcJlsG/8wToV
 LvFUZMDApUxGdBhZPwWOjTWtl9bRRAnQGmcWhmXxMSxa8JUtlWwQdsMvCej7fgidU5IXFibvAFq
 9LHITXkVw46OaV4f9LF+GvJMDExVlwUx8vfvsx22hxHMRL7TvM3/V1/vthmGp9SJvlXsoE7orw6
 BFZCgWDtKE7DNOMkN+V0abKZSt54pB34pkiaFepb0mV8J2WYG1aAh7chNo2DSNLbqqk+s9udPBO
 IbS3YoHjK+W8sVetbs7Lus+JnMPjm/ZGUw==
X-Received: by 2002:a05:6000:2887:b0:48e:3fc:e393 with SMTP id
 ffacd0b85a97d-49272a3af13mr7000425f8f.6.1793979674654; 
 Fri, 06 Nov 2026 07:41:14 -0800 (PST)
Received: from ArchOarora ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d84726basm4644488f8f.57.2026.11.06.07.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 07:41:14 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
To: Karthik Sarvan <karthiks1mail@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Louis Chauvet <louis.chauvet@bootlin.com>,
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] drm/vkms: Set preferred_depth to 24 for XRGB8888 default
Date: Fri,  6 Nov 2026 15:41:08 +0000
Message-ID: <20261106154108.515215-1-oaroraetimis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026071933.48366-1-karthiks1mail@gmail.com>
References: <20261026071933.48366-1-karthiks1mail@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks for your patch. I don't think it should be merged as it is.

1. The patch changes almost nothing

vkms takes the path where no explicit format is passed, so the
framebuffer is XRGB8888 before and after the patch. This is the
function that decides it
(drivers/gpu/drm/clients/drm_fbdev_client.c:drm_fbdev_client_setup()):

int drm_fbdev_client_setup(struct drm_device *dev, const struct drm_format_info *format)
{
	struct drm_fb_helper *fb_helper;
	unsigned int color_mode;
	int ret;

	/* TODO: Use format info throughout DRM */
	if (format) {
		...
	} else {
		switch (dev->mode_config.preferred_depth) {
		case 0:
		case 24:
			color_mode = 32;
			break;
		default:
			color_mode = dev->mode_config.preferred_depth;
		}
	}

	...
}

0 and 24 are two labels on the same branch, so the patch neither adds a
user of that branch nor removes one; it only changes which label vkms
takes. The only visible difference is that DRM_IOCTL_GET_CAP with
DRM_CAP_DUMB_PREFERRED_DEPTH returns 24 instead of 0.

2. This field conflates depth and bpp; no value can fix that.

XRGB8888 is 24 bits of colour in 32 bits per pixel. This field holds the
first number, the fbdev helpers want the second, and the switch above is
what patches over the difference - without it, 24 would select RGB888.
And the newer formats have no depth to give. XRGB16161616 and its three
siblings are .depth = 0 in struct drm_format_info, and vkms advertises
all four on its primary plane. Move the default to one of them and
there is no number to write.

So 0 is not a placeholder waiting to be filled in; it is the only value
that does not claim to name a format.

3. Deleting the comment loses the only explanation of 0

Nothing else in the tree says what 0 means here. The kerneldoc for
preferred_depth is a single line, "preferred RBG pixel depth, used by fb
helpers", and does not mention 0 at all. If that FIXME goes, the next
person who wonders why vkms writes 0 has nowhere to look. If it has to
go because the helper no longer substitutes depth for bpp, then replace
it with something that still explains the 0.

Thanks,
Oarora Etimis


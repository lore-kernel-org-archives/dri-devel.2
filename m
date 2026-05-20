Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6D9CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 23:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 248B310E201;
	Wed, 20 May 2026 23:33:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="b86xySVW";
	dkim-atps=neutral
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com
 [209.85.215.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D55C210E201
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 23:33:25 +0000 (UTC)
Received: by mail-pg1-f226.google.com with SMTP id
 41be03b00d2f7-c8016d642b2so2762034a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779320005; x=1779924805;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ws3LZIDjvhIy+vm9ZGYJAb+eJeCjXTtC/dRKNnpJpyg=;
 b=HHjZc8bj50BxeAk6OW5yMUm66h7ipo8GFaecOfOzah88kfBGCrpYxoRPGrXx2H+jb/
 NdHbauMVRWpEK2UjaeWogTQGapMcosWHzUUVieC8+TnCUYkT6tzJOPSpcxeGZWq/WbDw
 gGuzaQ5UlChUHOwLrInSFqiawBocvwR8VNW+r6mmV3W9x14kuioNAp3ITHtp0UETIZj3
 aNMIAP+ozZLMQXEO2cGozD4M7FJ9wmHvgP32UxbVfqA6i1JhSn/oc5gzPGClz1ihDc0D
 DH6dUxwMQ1VikDPYUmAzRhkOPhDC7taf2/AV0mZEBdwdd8Dzkk2E3RCLFGAL5LPk3K8j
 /Uow==
X-Gm-Message-State: AOJu0Yx7GvFHO8ESXJLjDK3srdefco4hYBSACoEKJ0L28IlQl6YAf+0S
 Yjp1HGhhcANTZfJQROpIwNb4F4p20IpIlGz9gw6cDqLFHxYf6GERF24WBQ2pozHHlN98NTGpfhm
 ySRTW6bQpC10VB8VGunuzmeaefpHb7CQtqdvteTxskzOPZI6pz5IqbZwuS6aAJgEnrwt+635j/V
 1e2rbqWV4A6b9U9r8oNimBwDYbMKICQl38O3Rm7oiB3/v/XkXZjaiRy4+f6vX7z8j75i5ZKiTSm
 3TTtjah7CgKwKp0zjpn0qqpdM+X
X-Gm-Gg: Acq92OGq3AAfcl12sPQGYYj5HR/PnMIgFKFj3tUxB78pbXt1KOECYh1ZvUBceGeetf6
 vPBl19rllms0716+mlVmEsbLTvPC3On31G0OAJSgRF4oj8Yb5hEKS+2inPX9mAscG27BON+eeES
 8M6sdJlFTn7aoXYoJVJWZg11yDR0xG5SLhgacFSYzVxGj8GZMz5xctG/mMI3GkgpV+4+zy2z1p9
 fYd4BphiLn8ALobMOQBUl8bQ7b4xY/OgPOdhQ3uhYWYZjLNLG4TCbPRrjeTQPStM/TaLUZustYI
 8JZd4SWq79Big7VBYc9dAK+cC+b1Zz8r6HdB2OrQJELZL6v20av+vuW8do5Yk1sQxpdseJHxwsU
 iRc1HHiVvfuz+kYUnLzei8mDMVy9qDKot34QWGE0G4Jr8GZr4+hSs/xJy47xeCBXufaOSPxZFkB
 o9vIwlvU+7TGTIG59RwT4UbBELEdwwjQ47vX6NcSdjxKSkXD/Ajcj2WVDDc9Hkh8SS
X-Received: by 2002:a17:903:2391:b0:2bd:2c3a:2a36 with SMTP id
 d9443c01a7336-2bea1fd2efdmr4383665ad.0.1779320005062; 
 Wed, 20 May 2026 16:33:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2bd5cfe2d89sm16767875ad.41.2026.05.20.16.33.24
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 May 2026 16:33:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2bda35eab74so4415173eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1779320003; x=1779924803;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ws3LZIDjvhIy+vm9ZGYJAb+eJeCjXTtC/dRKNnpJpyg=;
 b=b86xySVWmb+hRTsFT0y6dH+ALq4mytPqMPCJjd7lSsbno/+pzQRUgvAZ3K825r/8Ck
 kdiO24JhgHUn8Ik8o6ZJkXyOI/X7dUdZtw2yF6Nqpwo2HKB0EPHI96IS3YrQwIvOnRhv
 ZgF5xEu8+uS6E+KW1kFJ9PcRUU1T+T+cqoLkc=
X-Received: by 2002:a05:7300:7493:b0:2ed:e16:6b37 with SMTP id
 5a478bee46e88-30432187993mr211310eec.15.1779320003245; 
 Wed, 20 May 2026 16:33:23 -0700 (PDT)
X-Received: by 2002:a05:7300:7493:b0:2ed:e16:6b37 with SMTP id
 5a478bee46e88-30432187993mr211296eec.15.1779320002698; 
 Wed, 20 May 2026 16:33:22 -0700 (PDT)
Received: from [10.211.247.102] ([192.19.50.250])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3041ab8282bsm2612361eec.31.2026.05.20.16.33.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 16:33:22 -0700 (PDT)
Message-ID: <0c4e205a-31fe-486b-810c-0222927a1025@broadcom.com>
Date: Wed, 20 May 2026 16:36:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] drm/vmwgfx: Change ttm refs for dumb buffers.
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com,
 ian.forbes@broadcom.com
References: <20260514224819.3631763-1-maaz.mombasawala@broadcom.com>
 <20260514224819.3631763-5-maaz.mombasawala@broadcom.com>
 <CABQX2QN4yojsoZ9pkzw1y5a_PEaxa_nfur0V2qaKyiezTgYZHg@mail.gmail.com>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <CABQX2QN4yojsoZ9pkzw1y5a_PEaxa_nfur0V2qaKyiezTgYZHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

On 5/14/26 10:49 PM, Zack Rusin wrote:

> That still doesn't look correct. dumb buffers own the resource and
> should drop it themselves. What you did is made arg.rep.handle stay in
> tdev->idr and now both the tfile and dumb_buffer own the surface.
> Whichever one is destroyed first will make the other UAF on that
> surface.
> 

So the tdev->idr still needs to have the handle for the surface ref ioctl
to work on a dumb buffer.
Instead of having a ref object, we could increment a refcount for the ttm
base object directly, and then release it on dumb buffer destroy.This way
the tfile does not hold a reference to the dumb surface.

> For all the commits in that series that are fixes please find a proper
> Fixes commit. And if you want to land this through drm-misc-fixes then
> you'll need to remove the last one from the series because I don't
> think we should land general cleanups through fixes.
> 
> z

Sounds good.

-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>

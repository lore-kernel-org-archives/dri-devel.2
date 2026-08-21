Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CFCC5DF81
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 02:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8660E10E1B9;
	Fri, 21 Aug 2026 02:09:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="F8Kuc187";
	dkim-atps=neutral
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com
 [209.85.221.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A1E810E1B9
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 02:09:44 +0000 (UTC)
Received: by mail-vk1-f226.google.com with SMTP id
 71dfb90a1353d-5c2dbaf828eso294408e0c.0
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 19:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787278183; x=1787882983;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1mESdUPfdaRItN+jV6yaT0K7NDEbuV8oOiyCTuvZhmE=;
 b=oMEnyX6r7wrjQFk2MBbRi27fZWwwaht6BfUvemO6lQNJCTGdEKLKrAgtvHafMLOd5F
 7ad0909xmp4MCl6jmpQ10hB1Cq8OYRIWxMtxriM3cuBS5G5i9Az7e4eyb/kuVK7ja1pF
 sPvvXskD31SG38tUDcgaW2Zpzy3GwhqkkcZau2c+2bdj6pgmj3BeoCwV9YnehkC9cAhU
 OT3POd7i+a0Jb15fthjYJ6huWDGv9XmOvWqoixYMMtRAxOAfADTvdMSOLz/iuAaBrkvA
 4RUc3cfz71pAjOTLaAvebuuH1FA44etgtqqtQkS058e9I+UK/RoBPSD6TjvLOBeqmr8j
 8DZg==
X-Gm-Message-State: AFuF++lgXlgQFRKNXpv15RvtXr0ilZPwqWzage1Vu06TzHGH+/l5ok3J
 JKzb4QMEUwlEjbBnzEs4mUAja1sOuv/4jrgeqLYzSQTznp6ny0ULuwhzMKyDnTShlLG3lzx7735
 dEKA3QGGPyedk6SkyJBqTxm+e34JcwRHb71NQsTcv9K/VADp5ZZJm4fGEzCKwG1CBi8obSJTtqe
 a0/7b7ptc1ZAKojJGW7EDuUca3yIDa1u+9Uxasu+iy/ueiwlgkNIep58zd8gTzAwHEbDfJxMZrW
 kQDgVYRmIR+qLsg9ZifdMEiQ8eI
X-Gm-Gg: AR+sD10ItlYziW3Ad7YJDHwb35NZr1UJ90k0NDCTd0TsCygMNqLCIRb1elPU6UfuOvw
 y4QDlUoMWZOqs9sJn65GO/UP/1bKDn9zjtiL+A6l/X8e5OQxPDH5footjjSGVciS57NxedNiDdg
 oB4NXpLQlYW9Canl1g0c7kI/seoX2fHEApHxkzBY1Ob8RRDfkSDGXjgCrXWhV6miYo6zxa38mu0
 gIBmka7vcy3XzxoicPq50aqLCJe4tjEhRMfY4imezr9KxS376Q0Y0jesznR/zQtmsYivPd8s5SH
 WSFYi9luSkABJWvyeNbyxH/+mbmGRtH1AcrJubnfGareFCuw1DYKNYYOmHuFhamVjxx8h1ubCAu
 BdYSYD/PyPe6FFix45X8K9aaOxvWcMYQdM34WALj4kakM7I5W/E9x2qJVdtI1tbOrpynL6F2lrg
 Ixf68c2L+QiE3DjgntvPMUOv85omghA925yOtrTJdU
X-Received: by 2002:a05:6122:e46b:b0:5a4:c20a:ba4d with SMTP id
 71dfb90a1353d-5c5ff6be0c3mr1256300e0c.4.1787278183334; 
 Thu, 20 Aug 2026 19:09:43 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
 by smtp-relay.gmail.com with ESMTPS id
 71dfb90a1353d-5c5e27c3cb4sm1618791e0c.5.2026.08.20.19.09.43
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Aug 2026 19:09:43 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e1118e4abso745313a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 19:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1787278182; x=1787882982;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1mESdUPfdaRItN+jV6yaT0K7NDEbuV8oOiyCTuvZhmE=;
 b=F8Kuc187cyVoY5oRa9B0WvzzRQsGDbVYJP592rxHiu+shov1ddk/+ZQ8RwUZHikJ3z
 jNe9tmiZL12078FTIQIfxyIEKCMIjy29+NV8LW3vceaJP6RXRO94KixM9hny3mIyLfV6
 LPQzNg7HYSkp7xLAegZBk5MRLOYo2nfCpEZy4=
X-Received: by 2002:a17:90b:4c41:b0:380:7688:fbe9 with SMTP id
 98e67ed59e1d1-395c354ec51mr4447494a91.8.1787278182228; 
 Thu, 20 Aug 2026 19:09:42 -0700 (PDT)
X-Received: by 2002:a17:90b:4c41:b0:380:7688:fbe9 with SMTP id
 98e67ed59e1d1-395c354ec51mr4447430a91.8.1787278181746; 
 Thu, 20 Aug 2026 19:09:41 -0700 (PDT)
Received: from [10.211.247.235] ([192.19.50.250])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ae48761sm19219055c88.12.2026.08.20.19.09.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 19:09:41 -0700 (PDT)
Message-ID: <7af1cbb9-bb99-462c-a3e4-c70d8fbd2dcb@broadcom.com>
Date: Thu, 20 Aug 2026 19:09:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/vmwgfx: graphics memory not returned,after all GEM objects
 are released
To: Jellis Onsea | AccessWeb <jellis@accessweb.be>, zack.rusin@broadcom.com
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com
References: <66c0b5db-bea1-4608-be8f-bae437760d97@accessweb.be>
 <9ad23800-db89-48f2-a960-6c2fa11ee6d5@broadcom.com>
 <363bcf88-1f13-46c0-9dbc-aa21102ab397@accessweb.be>
 <55b08fb3-cc29-4c2a-bbe5-26742de77614@broadcom.com>
 <b0b0caf9-ca76-4f93-9495-d386d313fad1@accessweb.be>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <b0b0caf9-ca76-4f93-9495-d386d313fad1@accessweb.be>
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

For the 3D-enabled case, could you try with mesa 26.1.8 or 26.2.1, both of which contain my fix.
Also if you could try the patch I just submitted on dri-devel - drm/vmwgfx: Return gem fd handle for scanout buffers.
If you still see issues with these patches, let me know.

As for the 3D disabled case, I can see issues on my local machine and am working on a fix.

PS - Your emails are overly verbose and narrative, could you include only the actual problems you are facing.
If you're using an llm to write these, please make them more terse and human readable. Thanks.

-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>

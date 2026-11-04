Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185F0606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 01:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FlOY30mb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43F7A10E335;
	Wed,  4 Nov 2026 01:07:51 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E4F210E335
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 01:07:45 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so1053075e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 17:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793754463; x=1794359263; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IkoTUr12d3aBSwhfLu9j73ajMyz1vUUn+p4JbB9hc1c=;
 b=FlOY30mbQ3lSm6aWqxHnbUQK8lxH+aJxXBtrfFao3+T9PtVtEToBir+hPcHk+35HkQ
 wiCtcLPFLV5GaEDJ7Zx2DNIbKhwZSYntc5iPZaWuBh5Sdo8GBJgzjJ/dIKOT4awD1ko7
 l2BBy+MZkGwxYelRP4PZSPrMm0vdTdb7UkIEEHlEob9A8ScBZ6nLenqJxelr4lTgaBH2
 feu3lbiqG7Yi70Kmw5GmNBeGtnATjMKSPp99jwooNN6u9Kxy6erGkV29HZnbptJ/YxeF
 htQBZMRPfowKTBHQMPzg/xnt4ETOroXOzGyECSR+hraODWu2BnWkudytLECOM+GL0XbN
 eKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793754463; x=1794359263;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IkoTUr12d3aBSwhfLu9j73ajMyz1vUUn+p4JbB9hc1c=;
 b=aTOKZphlXEUYxqrbu6uaeyb0aurqD0DjnWwKHEAPHNYuJW98jfWTONhE+gRTfbQQ9H
 NaS61bzzdfL7LludTXRJEO82YAYsI+NGhFXUanRlLFe4H0zcgb19SqCDfo4j0okwPQtH
 Ew4SsZX7MBNLrZPCJAsdIcuDqj9uNqS/I1KJefzW4/yaCNwEbTaAQB4YUFJQxqmgKNMx
 BiA1bcIHbHQIjCenz8EQpbsLKP7MxdOscIMLeLbL2efXcPv7o3KK3NBEB9cGL+fgT3OI
 yrXt83rH6Bl4qSvUJgaN84q1m3aaxO8+g2wotSuDj4Jdd/JN1hPYvNAvoH53GBjICtBc
 j1Jg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWeoeLw2lzNr5JSwnBwXxxb8eY8q6S6zcy4EILHHLdnTbhRSbssBqoO7T7vr4AoW6SRIbf+53oo7k=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z99UMHkOB0e+f36VXUrYPPWtDeTYzvua+a1nqODOrwiQFJW2EmY
 kY5f7U2h8Kwo0Fe0CESE6FZ0XxJAYxIWf/3N5wEqVaH0w5A1FtgVBfNQ
X-Gm-Gg: AYBFou05OjAIsE1uZpFRRPUevw0Nw81FnN9Degyhg9/AD148b1H3TVRTgPtuUIhJHWi
 X2s+C55kjK6IBU1UfR55wwaEXzyPiExrEwHEIBq1v98hllPFIXepZuBNH2z4ROr1FWM9kKTsXlZ
 /tvwYsCmulYJlZwvAauvD+0c3JlImIIVFKIQcB9wXgH5TT+XpEP/5fQH0xBuJb+LrOZ1bpwv8Lp
 3a2jNhy5+HvBd+xHmWwLoiVEGIIMZuVCkPbHuOWxJrQGbox+Nzj/DLFAC4+aAw/WTAsSfthuHM9
 Y6xDG+ULlUCWIuyoOvw9UcE2XCp0Js9f7NrMHe8sUMmrcK763VbVM6NjQ7bc4x8obTyytV5ts6x
 XtfCnLhPcCGD2blf9vRiuSUmD1ShDNKCQnrLbRCbOKMBeUnCnF2W91jnfESsWw2YiT0teamITlf
 DfNRY3frRtmkW78rvhCRKLyISoXshzH2y2BorP/SEQv27Caec/6XZI9YSPV/0yF572G6/gcC3fs
 9xZHZf9u36r/R2tPYv6ZJboouvTs5FQvMIwx6eoGqAxgzOk4Fhd2X2eOWGV9eZXZMfad4zAfHFG
 caD6l8ZeY+4BtLf7yn+5dcATyTP9A0aAqxTaP5mTXJEW0XF0uKMFW9+umrpjkFfe7AVrfBZVPcG
 MpuDuIs5ptHvQb7iumrOEE17KGEIgkxuKxGDiuawF/VoethPaU4Ooa/ol1ZrDkxcGnlLcTq9740
 NiPw==
X-Received: by 2002:a05:600c:4f0f:b0:4b3:ad9d:e21 with SMTP id
 5b1f17b1804b1-4b3ad9d0e48mr50657685e9.12.1793754463523; 
 Tue, 03 Nov 2026 17:07:43 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2ab00ff3dsm181749615e9.14.2026.11.03.17.07.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 17:07:37 -0800 (PST)
Message-ID: <50be53a4-0136-4c8e-97bc-2cdc1caf76fd@gmail.com>
Date: Wed, 4 Nov 2026 01:07:35 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] allow dma-buf-io ctx reuse across files
To: linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Nitesh Shetty <nj.shetty@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
References: <cover.1793751001.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <cover.1793751001.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 00:18, Pavel Begunkov wrote:
> Currently, dma-buf maps can only be used by the file they were
> registered with. This means that we can't open a new file, even if it
> comes from the same subsystem and point to the same block device and
> use it with an old dma-buf registration. That would be too restrictive
> for upcoming filsystem support, so lift it now and allow reusing
> contexts between files pointing to the same NVMe, even if they refer
> to different partitions.
> 
> To do that, we add a tag representing for each file, save it from
> the file passed during registration and use it to reject files
> which tags don't match it. Tags are set by subsystems creating
> files, should be unique and represent the instance of the
> subsystem.

Fwiw, sashiko raised good points, I'll need to address
them in v2.

-- 
Pavel Begunkov


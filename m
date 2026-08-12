Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A44C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:42:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C636910F253;
	Thu, 13 Aug 2026 09:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lvMsNCIq";
	dkim-atps=neutral
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com
 [209.85.208.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C16EF10F083
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 16:08:49 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-39c74c469e8so8551861fa.0
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 09:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786550928; x=1787155728; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oNJRftlCpqAuhIcSsEDeWbYcn6HY6cIaqGW1v3wUJm4=;
 b=lvMsNCIqlFRvEJ3jvHRX65pFDXuJJ+7E3wOTQFuAx3Hfc5QJ18aRRHxW8c5ZZCJq3k
 PexpoIqKsn1tTN2yoWaYRDDL0MDsMG46+KYcvQfB3koDT87wFrTpALdM+tSFXQ+PiRct
 3gE3HONNbkcIyRuRQYj/RaUas7PjfVqIKUzUPkgFiZQbGOeMN279t83inve4wpjPImK2
 btqsmL22cZWjWiqtmVHuLIal2bQqqkuMzjnn/vRzcs7Ghox8Yftx3q8oKnrRvxmOCZ/E
 /iw/+0sbk83jAP5vbOiSZCc/+a9wYBxAEsy6gQkK0hqgMxGTkS+Weisn8SNzVb6gxgnZ
 aAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786550928; x=1787155728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oNJRftlCpqAuhIcSsEDeWbYcn6HY6cIaqGW1v3wUJm4=;
 b=TVPpI/HMZb32hhhsZlbpEMvgQYWk90Gxu0nwsyKC26YwePoUUy//CBIRTHZcaSOm9k
 wAHvVb/FEw0Sx0o2LkMh/hYjkdmz1f0JOIRvZwhDbylGpFKGslZaAc7ULaUGFRvWYw2T
 G8JIF0eBfQYNnSOyPpJ5NQwsD9416Y3h8xuzyhC/gJTfyeSUphWUl73JYLPdQZu9zs5o
 maGeh/cXrDl0uom4KyhpZ2OrPTX0SLJEf0rplKe6uzJpImiQDsCmYsj55BL9n+s/IMiA
 SfbswiTMYkom1hARc/5f5asp0wz1ZOdHD64EIjVNWnVCVKSOLlO9EX8mfvQTbB4LkMYd
 rx+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqKSB/EYaBCkfbvi6kiX+qMsxv8nh3o+lgg6iD3ubf7ZBEteeURvai+W4x8CIv/8pcNnSpJmxCRWJw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwI/ExZWOe0e47EIb73xPaDqEbJenR4e+bu+50L/TkcL29SkqG7
 XgLraYA+1f/ffeG/Vs6JY2reZ6mhq8sjFIG+2tXMRkDIY02RHYD9xYsF
X-Gm-Gg: AR+sD10yZOSkBF6zskNaIq+H4F2PTG9uF4PKIh0bm4Q0h+lY6U2PQP3KaYNxf1fla5O
 j9mdvxOln+sWRkH8j/DH1m/yCJPcnsL5fyNLPv5wZ9px2GC3ulyW63VqcTPZcZmjjlu4UxnuuJ7
 NUXmhh9ioGawWo86UKpSRObfFAcS2rsrrm3dBlwrlEK++EIfGGfN/EN50xcKnJfwZLynvfNhKR1
 uuJpf1tmjq8gW57yNWBSZ5zLiKY/ORCK09FH7ZFGxJixsUxc/36JVimBltQ82WFU20vmETkKCL5
 m3IJIH8zwp9lmDxdir4ynBbohQ5OHUguQ8koDObjaw9Dlq7gByPw07G2Jt3QzwGqEX8N4pqJwny
 a76xZchqyd/tgTrXdJBBUGRGxbKG7noalu4qXF1Bsvj+PZwAEmpzz66J3bQb9fpTC/RE9jnI/rN
 WOZd+WiKxybH7WZ9l0/45DGa4/p+b8Abyy9Y8rYXFG51HWM5vjB4I15kyAbBEm4bH2bb8=
X-Received: by 2002:a05:651c:50b:b0:39f:bc94:eb9f with SMTP id
 38308e7fff4ca-3a10d575723mr7410061fa.14.1786550927596; 
 Wed, 12 Aug 2026 09:08:47 -0700 (PDT)
Received: from localhost ([95.190.110.153]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a1084da93esm5290891fa.39.2026.08.12.09.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 09:08:47 -0700 (PDT)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] gpu: nova-core: retain the GSP-RM log buffers
Date: Wed, 12 Aug 2026 23:08:45 +0700
Message-ID: <20260812160845.2017730-1-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <DKN35E0L9X9L.RSVUGPFWRV69@kernel.org>
References: <20260812113752.532537-1-vladazaharova2018@gmail.com>
 <DKN35E0L9X9L.RSVUGPFWRV69@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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

On Wed Aug 12, 2026 at 5:54 PM CEST, Danilo Krummrich wrote:
> Unless you already know and decided against it, a firmware archive containing
> the compatible firmware for the current tip can be found in [1].
>
> [1] https://github.com/ttabi/linux-firmware-nova

I did not - I only found that repository after sending this series, so the
older base was ignorance rather than a decision. Thanks.

I will install those images and re-run the same checks on top of the current
tip over the next few days: unbind, a probe made to fail after the GSP is up,
a second retain for the same device, and module unload. I will report the
result here.

Beyond this series: I have a GB203 (RTX 5080) here running nova-core, so if
any pending nova-core work would benefit from being exercised on Blackwell, I
am happy to test it and send Tested-by.

One last thing: English is not my first language, and I use an LLM partly as a
translator. If you would rather I did not, I can write these mails through a
plain translator instead, though some of the meaning will be lost that way.

Thanks,
Vladislav

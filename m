Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E4FC5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8404D10ED36;
	Wed, 19 Aug 2026 06:37:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q1ETMPRv";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 587AE10E480
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 01:31:45 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38f0f132f56so404250a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 18:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787016705; x=1787621505; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nDwTmt2AUFVhieHUgzWmzMtZYA61Q62iijIjthQqocs=;
 b=q1ETMPRvmW+ISY/qSPl84paDaN49WHFaZn2hY6g1lK1jyUbHTOm7mPEJ+3eAkjmLJB
 8qmGEklyMYMwuVA1j5zUPgVCclXkKNZoO2ov9Vt9tSQzkBItbs+ZWHHsmP/YCneHNVEY
 r1nWnwhUvi48EvwByYtkkaSedVwpPrEQYxlUUKhtd3MjnwNC9FP4BalnHTD12PrgoaGT
 JprBJaA1Z5qBOqFWnAd6O5RIRwnxelSUNvhLOL8T6q2Tpk3KvhV14EVMy/fB3uSl5God
 bKCHQZ/kcteWsjBCA4PvzN1O79P4FiI8YjeayJU4N2FdWBLhNeVETbBmuCFeKYDCAKLs
 gfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787016705; x=1787621505;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nDwTmt2AUFVhieHUgzWmzMtZYA61Q62iijIjthQqocs=;
 b=bCakw+coMVFKoGBeGzSNgNgPPxRTF+jmJj7t26od/tHYGQiTFGFOPKQYc2ozRBQPl3
 OfLJs4kWrdhAJ1F9fY924pjIbFoIlJsb1BB/X3Gsk+RYJGX/xJ8VP25LRhLtetNsUidA
 loy/doyoDZDEUdxIhF2a9zv2OeIJ65qJquzBbwLaZPoMqhfiLok25rBrlWwlB4EeBosh
 jFfNbhI6csOZjGIVzL9JRGznXQDMWL4UdvSQli4a4ehnXsd9zPHwyXD5pnI4KpkDZutu
 u+fRPrRnjHNU+seyrLY5xgiBfBogTHNgMkC+25UUKjiXMxvQAbKe3KH4RzMYKCAH8AhX
 QLgQ==
X-Gm-Message-State: AOJu0YwASDaDtE9FzBJ3PGg0VIeypGjpKG7pAjFSKZ3wCoSyPbC5AauJ
 yh5v99uXEVbL43vNToitRa+M8miHT86a6u6Nn/i233bcPKRrBSO1ZPU=
X-Gm-Gg: AR+sD128d+TnTeiYDxRtxf7szY7MMlMhlLWBP06CiaAw9OeOWuOJCE2UeDVvD9Zhifb
 hi5U3gm+oW3cRFS8kkp/gtrM/gUD0bkm204NHYbPzgiIzPEAcX7D06O1GfdkPN82uhCOFLfrxSw
 Ytejr0ZSID+LXzpiFJE/UndcszgQpPbirt6ql82HLNBVLVK98SB+cz05/1Y7aWFTtVEYIPA6Iwq
 d+sjSpuiTtpTDvnSaXIS927J/1M8Q227IE6Tct/Ga+K/lM6PAyraOZueak+QkcC5FvTI4Yjo4Y9
 SKXcZejWdL2Z3SGxG/Uth7HoN+pYlJ8OiXKw3V9VICp/Pwlhl1Bao2rlnPdLNCB1goukxWBh1Oy
 2HXJoRssCA2L+tF4LmcQPKWStxSCKOPO9oAZ2EtL0U6tI/GuV4G1Fp4FyYHdfar2EERSf1RRa5o
 eQ3gGQCR/at2SmKOOcH/AKSRGK33It+ByOu9tcDkAQyl2i93AIf+VENenh5nDo
X-Received: by 2002:a17:90b:1dd2:b0:38e:4f42:d0d6 with SMTP id
 98e67ed59e1d1-395638e8a5bmr1543834a91.12.1787016704739; 
 Mon, 17 Aug 2026 18:31:44 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3954d2b85b1sm4179445a91.2.2026.08.17.18.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 18:31:44 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
X-Google-Original-From: Triet Hoang <triet.hoang@datalogic.com>
To: markus.elfring@web.de
Cc: dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, ogabbay@kernel.org, royalnet026@gmail.com,
 tomeu@tomeuvizoso.net, triet.hoang.dev@gmail.com
Subject: Re: [PATCH v4 1/2] drm/rocket: Check allocations before use
Date: Tue, 18 Aug 2026 08:31:19 +0700
Message-ID: <20260818013130.1482249-1-triet.hoang@datalogic.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <d593bdeb-e6f8-44d2-a444-e9197a8ed1a3@web.de>
References: <d593bdeb-e6f8-44d2-a444-e9197a8ed1a3@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

> I see opportunities for corresponding collateral evolution.
> How do you think about to apply the attribute “__free(kvfree)” also in such
> a function implementation by another update step?

I am not sure I understand your idea.
Could you explain more? This attribute is a new thing to media

Regards,
Triet

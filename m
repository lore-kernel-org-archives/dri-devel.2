Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60080C5DF89
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:37:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D9A010ED13;
	Wed, 19 Aug 2026 06:37:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BrIHF8r7";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BF7910E484
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 01:55:59 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-84847482584so395269b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 18:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787018159; x=1787622959; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RPdhnhqEBoOVYAbda7H7EtqRNNEIC4qPdmFQQQ3cqr0=;
 b=BrIHF8r7oIDdSeh2rt38Bl7O8Op5ywZB6gBvBWMOoIWwHsrlxJzp1LJgwR0cnZhiIS
 xP1ebt5sdc4zgryuMMLTfpxlYixakpQ/VE+bl6rFgvUoxmz5nqlDjyMokmLNOk0/Snwb
 yBoqMoHHz2G7I9XqaRmiaedGlg5OFjmF/vG+0M9F793GhvsmTsXhTmqIx+xTI99Rw3/X
 +WYwMwbwUHmlgwQ3zo9z6jnQGGBFrfEr1ynUzO+D6zE5ChdHFRKlpG/LK1sliJpdDlPo
 arduuvH9WT1YXag5VlQBK12IukMpU8chDsulYgN5S44/2MIE4FJorzgiDO3cKTr7hDZP
 r/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787018159; x=1787622959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RPdhnhqEBoOVYAbda7H7EtqRNNEIC4qPdmFQQQ3cqr0=;
 b=nBUZxHyRaF49ifhvdyYaFUaPK59a1MkrRmWSzf17N0MMegqtcBtXTZwIcPrCqeLJnL
 EAxXZRFFsQenNnTEUxX9O7+j/BBlT2eZo4hWRbs/Y8OCKolZOT+GVXVQrzOhbvV/NEA+
 yW45bX86lWh+1whx7jNppTIP5bu4nISk7x5XqDT9HiPuzJqWckOwBWXC3O718X3VxyHB
 Qg4WJW3Ps8LsbvPjNygA8akYDQrqrhIWEtifB7vupspKfIQ9PyyeH6WbUHtS9RfiTYvg
 V0391HzEBVML2Gmz/5LNoj1j7hpDKZ2UDgo+02CeQRFtzfhC2qygHokBvEKhd9zlEOLr
 ct2w==
X-Gm-Message-State: AOJu0YwH2pBpakpZNizUNwUxCfh5ZFp2mNWG5L7SFPKEmIcufVJC2DVs
 I96CSdABYXLFECOmlz5U3h/okHAJPr73oYHtIga8tnyEWNCA1kGuC2M=
X-Gm-Gg: AR+sD108myjQiqmF4xa0rlFwWxHLGwR5bbJnsiQmRme+uHUOdnYk8uVu1fwPvuIjaai
 WZtAkYP269vDBhQqs8HMLbXNc/OyD57W100TgO3B5kWhPzM7PxaYwk3TNfOoAnuUjVwAAuPZWwy
 kUU0JZ65Kvlo0N3zzghTaOpyYqe/SqUS3Kk+iWElNveTvg7L6qmoEOehp1ZWlpMtd3S9w2XoONK
 bge+dDuWzAXabLtK7AbEjU+uUV5iGdry5KGEEq4CRH0LaVFWpNUGl5WUrdyWhaVLpCjfCQ43OHX
 2HqBVsM2y7oOpmaJQV6L0UoI1jUHUqTIEQhBmjeAQ3javPVxs4gRCs1k9i+3LCCnGiY5zKLX2oK
 9hNcUeAVMCGxfsta3KqhN7jFq2TMtaeca8NgOSgIB/hTTvoPpgwTwzn5a8CaVvhnQS6RtrNlTli
 C6LT1MA1pYahs3v+T2wMFEqkqlxJszAsQgviwJXgcDNteXV/FD+zU6qPUhSJw=
X-Received: by 2002:a05:6a00:8e09:b0:84a:29af:a0eb with SMTP id
 d2e1a72fcca58-851be5fb7e4mr1800536b3a.9.1787018159456; 
 Mon, 17 Aug 2026 18:55:59 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851c2fc690bsm38404b3a.14.2026.08.17.18.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 18:55:58 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
X-Google-Original-From: Triet Hoang <triet.hoang@datalogic.com>
To: triet.hoang.dev@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ogabbay@kernel.org, royalnet026@gmail.com, tomeu@tomeuvizoso.net
Subject: Re: [PATCH v2] drm/rocket: Check allocations before use
Date: Tue, 18 Aug 2026 08:55:54 +0700
Message-ID: <20260818015554.1496707-1-triet.hoang@datalogic.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817142821.161070-1-89897892+HMTCT@users.noreply.github.com>
References: <20260817142821.161070-1-89897892+HMTCT@users.noreply.github.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:31 +0000
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

> This will look like 
> if (WARN_ON(ret) || !(&rocket_priv->sched_entity->sched_list))
>  	kfree(scheds);
> How do you think about that

Hi Igor,

This is a bad idea. Sorry about that and just forget it.

Regards,
Triet

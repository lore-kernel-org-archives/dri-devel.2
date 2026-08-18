Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F982C5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:37:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BE6A10EAF8;
	Wed, 19 Aug 2026 06:36:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WiR+hxxa";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80BB810E484
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 01:56:06 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-3810c5d691bso2957127a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 18:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787018166; x=1787622966; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RPdhnhqEBoOVYAbda7H7EtqRNNEIC4qPdmFQQQ3cqr0=;
 b=WiR+hxxaCTcxMMTJ+3kAlNSGpxKGUYUJZJyWyJMzvdHvvDvojOwS5ooNGoDeOlEDeV
 MLfdwRh7GnVWMrOEq6Y6vnrdjjPuSEKcbytTf8Jf2HfVFRe13e9DPDlZyu6XgT3ezPPB
 zhKB0Zlv4CL7kipsyLRlFvZ0rxOcjMbTrQk0lMMyeF2m3ExDEtbPvD1KGkMTqoH1Btbo
 AUKigMfz1SesWgCiDmWR4llud9hUirHmIf08+776Txza0CWxoHK+5sSSyp4M6JngOFvr
 +O/1nwh+BiTtssvXLMl4NXxYNQg7EGTlkN2fBOWYOORnr4omemi0PqvvaOaZzKn502sl
 H8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787018166; x=1787622966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RPdhnhqEBoOVYAbda7H7EtqRNNEIC4qPdmFQQQ3cqr0=;
 b=ekBYEL7D6xjRm35pOuIpkEGlCh3oGqlxtN4zvd3+M6KNpdj3lIkm97+O2WR3p4JJEN
 SjrwA4QRoT3fe3KHtFNr2UblNC1Rawg1+hXfbybgz6o0i6mXdiL9ouGFiKh5ACLtuYjk
 9mc6XC+3fPrF9Ws62qD3pgtAdtnJ4GWHqL7iG53cPdGhet3Gf+Zm0MJNaYhvtDOmgVuc
 jZx1peXOSREH9BFXzedmJTPuJE/7EiOUPI3/IHQc+cK0lueoWkvpzrotHkt64OilnLbI
 euIa2vP3yT+4vdZbqbtS86l4eIQ7T6DCOrAvjKoH8+eQVxBbaimn2i0Wj57FYer1brc6
 OOZA==
X-Gm-Message-State: AOJu0YyASb5f6whBp+2pQbwAclhzRpZPytRZQ5OgWI7yFusj3DWeh7tq
 PMQfXiCV24FJ4+wVAB8yDg9GPW8RSnfIXd52tjvypyFRyP8ROiTcweo=
X-Gm-Gg: AR+sD11QY5DjMfOlg8msCsfZaYOX8pi6sOI3h3leJ4grM3riqB3b+63+Ith8aMURl+2
 4MYpmEtplgSeJe/nm4j6HD3YHXMKD79CZiZ+gvL/XnhAx12FO2w6QePEPxsvvIIDt2oI1qZyPBp
 +w/KuvEei0BElZtjkp3bvcvtEmNfYQE8D1jjg5Ga18NcolUaSau7/+67OLGAlPE277yk9/q3W/I
 tjTTOPs4ZUqxMvQUKlbPUikz63V9nrYZh7tVentU7I/YBIBCuNl2GbVCgrnOk5H9x0ePOVDFJlA
 fq5BRinEKkQ48GjDKg32tOGCqzFZ0KvntkfxOGh3f0Jcp02oLdWufjE1BSz8mJHcI5XIfXThc0Q
 IZkscQfSH3mdwsu6uZ7g3FmDnOd7/s3jXDxMTJ6cvmtRFFMmQ83+LSldtOzXay6vdi06yk6ek4L
 YQwe6LlwrJAvL2b/nimFJAkT7PeJbS2Nl8+a8WFdQ423OSXIxY6fWZCkNVb0M=
X-Received: by 2002:a17:90b:5803:b0:395:4e0d:bc60 with SMTP id
 98e67ed59e1d1-3955a70ba38mr5244871a91.9.1787018165953; 
 Mon, 17 Aug 2026 18:56:05 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3933b68adefsm5552617a91.3.2026.08.17.18.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 18:56:05 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
X-Google-Original-From: Triet Hoang <triet.hoang@datalogic.com>
To: triet.hoang.dev@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ogabbay@kernel.org, royalnet026@gmail.com, tomeu@tomeuvizoso.net
Subject: Re: [PATCH v2] drm/rocket: Check allocations before use
Date: Tue, 18 Aug 2026 08:56:01 +0700
Message-ID: <20260818015601.1496827-1-triet.hoang@datalogic.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817142821.161070-1-89897892+HMTCT@users.noreply.github.com>
References: <20260817142821.161070-1-89897892+HMTCT@users.noreply.github.com>
MIME-Version: 1.0
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

> This will look like 
> if (WARN_ON(ret) || !(&rocket_priv->sched_entity->sched_list))
>  	kfree(scheds);
> How do you think about that

Hi Igor,

This is a bad idea. Sorry about that and just forget it.

Regards,
Triet

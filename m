Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFBDC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E00F10EB5A;
	Mon, 13 Jul 2026 22:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gy3Z6Qop";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 843FF10E642
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 19:37:44 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so2808525e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783971463; x=1784576263; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fkT9lRkMwYghu/2SsT5/Spxavix5VefOiOOVGSHvrjs=;
 b=gy3Z6QopNlZa9LeKaUXJvwuT0K99PNu86pGJNbyMj+a/nbtpO2VTY2/PZm2bzt+F56
 ZbB0uxqT9IrBXiqAnk74WDl2/DsM06p/UiQZdKz0yk+reqrt+yoS2bREv1Te2IETJiJv
 FOCEFCyXh+3tRcwOXj86DGgSC8qvq4q2bK/xG69Umt5SqznqTgCUXWP/MqZIImoZxa10
 omb2jywTzxD2wuG5J3eFoGuBMHGnHTfqOutUyru27LBdTdxcuFc50c1GuU7QMwfABaYO
 iqo12/khqJkzPgtuTgvR+aifFW3cq7uW0Pqa48KECyCUV12PwK7rzp+8QKRJZhV1OUph
 +J6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783971463; x=1784576263;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fkT9lRkMwYghu/2SsT5/Spxavix5VefOiOOVGSHvrjs=;
 b=ZhKmCDQEq0HBPkiEuduV7pV9j1ntq1rmZBiPSARuS3eJTn5xN7TDc586fSyUwVy5GR
 2qng7sGs5KmIkYBxh3HvF8Rmo3mpqvlGeI8F5Js2ZUWsRFQsKxho7cKe+VeYeXZEJyGj
 TNYkyisTTB2rth9F/k4zz9PKAd5TtX0K/OlmsroL7y35OpfoaI6v3xGpBB1EYt8kxAUE
 nct1qDL86NXaeDJEIlTb3cpC4o7MLCH5BdJ5Q+DKK/qBeGVk5AAUTd2uFxjV2/3oqWxa
 /Mae8owxxIyFyph5yI5fw7pl836jXFuExZRGBB1e3Mf555Bz0ocfqH9JSr3uPPiC2Jo3
 PeBw==
X-Gm-Message-State: AOJu0YzDA0KqtdWPVyGK3ldpReOoQYGvjjjH1LCB6gSFN36YTaeXyDbv
 wGNklIXW5R1rB0BFHKc33gio6GGmi2tnKd3iitRP/8WCPVvz98JfV29HPerMDbO58P4=
X-Gm-Gg: AfdE7ckgoE8JGiCU1bG4010XkZ6YAT3jIicQgxdsrQkRSmAUDc7R8ktFq0P9OHdweEi
 256FSnb+SYbP4dEQm5IhO97V7ZfNc1Ckqq9cHK5I95JzvLsPZBdGbk1Zs258ytjOrJyu/P7KdhJ
 7FU5MpQvzTlc2ge1Fs+nIDftNPeQuRHNbgjUC1UTDbYyE91Szu+bojPvXfqR+EnwLUBkijrcfs/
 ly/hJ0svB6P8F/BjsWt23mncqMvKQcCx3Cr0X8mzgqOLfL3uVwo/Acb/wokncXoq/imeMJv3cAe
 sokK6fkSA1AP1m6uW+Qrx4hcK4VXjoR/7TlkJuPz8QukXUiRCYYwsloQbqYN6Ym1+8oGz8QT2u9
 DTxRBw3stzOlZUP9FR53WuFh+YmXcbYFcOImNS+vllvY3LuhGCgUtA6sNZcLDk2BbR51l6ajgqn
 AbniVK8DoAc5I7Rnxn
X-Received: by 2002:a7b:cd13:0:b0:493:cbd4:8925 with SMTP id
 5b1f17b1804b1-493f2a85bcbmr128448055e9.4.1783971462835; 
 Mon, 13 Jul 2026 12:37:42 -0700 (PDT)
Received: from localhost ([193.30.163.202]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a9879sm2025314f8f.22.2026.07.13.12.37.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 12:37:42 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 21:37:41 +0200
Message-Id: <DJXP3RGL6OH2.2FBANQ2HJV2J4@gmail.com>
Cc: <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amd/display: Use drm_edid_block_count() instead
 of raw extensions
From: =?utf-8?q?Timo_Pr=C3=B6mer?= <timo.proemer04@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, =?utf-8?q?Timo_Pr=C3=B6mer?=
 <timo.proemer04@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260713183841.5921-1-timo.proemer04@gmail.com>
 <20260713183841.5921-3-timo.proemer04@gmail.com>
 <20260713185052.9251A1F000E9@smtp.kernel.org>
In-Reply-To: <20260713185052.9251A1F000E9@smtp.kernel.org>
X-Mailman-Approved-At: Mon, 13 Jul 2026 22:35:59 +0000
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

Thanks for the report.

I have fixed this issue and just sent out a v2 of the series.

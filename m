Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07AEEC982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F73210F2AD;
	Fri, 18 Sep 2026 10:06:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A6qDIZuY";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A926110F2A2
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 10:06:08 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-48583cb7d44so72000f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 03:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789725967; x=1790330767; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1cDRNp7sN30u47HZEONtfi3hMQ/gOuKGJhHadwqE0Vk=;
 b=A6qDIZuYvaGIM+wdF9U2SU4PdALsuJIrGSjd4136OlR9uwa0i9g65ZaaeXD9+lbWhs
 MtGOP/Dry5DUaekPDSqn+7R1GrF+n9dl1hC80M66+do1SG6DZhoLvOh277+eqze7tCkD
 otsvs3bgZm1RMkp4Q9qTHMEjlwe8ofjINw0+LFrFYINFwiQm3RsDcP7DCihswxE7GiTh
 5Lppn8zWZFmrNX7aS7f7P8OLJWlC+Wq9QmLEy1HawWf6SQX/P33xf95upHq3foJ04+5A
 y3J8D9SurEoSZtdNvyGG3I0OSbKuNpRWYNAF1izUDXN3QHhtFmsUXB+fw6cwond8uoe1
 3QRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789725967; x=1790330767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1cDRNp7sN30u47HZEONtfi3hMQ/gOuKGJhHadwqE0Vk=;
 b=zXDwfVTQ9hX0ciGyfYhpsr0zIlzXdiaVPmA1iZe4g0OKVWH7WNhaxYi/pHujSGjJvA
 GKpq0QGVpzoA2GrsVQe53Ay/mbIXYVev30q1Un9bUf2wxu90OJFMXISTgBeWEjacOUBM
 OKbBdDKnAggY8HiyIsYvDwvgz/ysQlCabSuUtAQ+2P5rFnZQjCBZOIMNXSPk41qRfQ66
 f5Xw6KoSM9+hk3KwlIu9UhfaU8HJI/uWvz7v7P8CfV5oJF8DFkSzXHo7TRuUvY0cUu32
 b2dpO2C4do4cjMK7r4re4LLEFN85a5DoH4PL7qlrUDLMisbnACFoujsc+PDwc7l2ZegV
 zdng==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+LxEanL1JHCCnvom1/wNTPU14l2COCuxar+fpIBRwXlhcWLpiZzFGUlsq4Uxoo9PIxJDfLnCkwNU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kAxrKBZlPGvL8sU4oY8TWq+WWeFB2cG4W3So4DyCTXnKrUbF2i
 kTPy0n80ASrbFXlXYbk4rRnXCI918OH5AdQSVoLCEZh5w37Sb+Z6t+Kg
X-Gm-Gg: AYBFou01kiNKpKUnfmjp35C9WYSbOtRD1I6k1sFCxbAhKeTS/RhwfJODs8uA34nOYx6
 AdCnmfZAbo8kD38wqFYWiUxJLPS/bIKbL/vq6asHQtUZVU6IIg3RZQCx55jl2TFJgkARyYzl/JZ
 v5OV7Gkd3olMGogxvPhQRdjERMpdKUtTxenDTvyXFth7LCpDPHHotOBNyYWhW1P18wa73/sbbZP
 g8XQJfJvzS6+xbf89brK6oWJ2QJZk/U2k7Ja7mHhXjHPAtxtUHXFbOrBE9wtzkliV/6TlvYsbC5
 fh4J0f5bXI6hKnSHuPDO08rCjaNnCXy75v/s4nJL7wVwREX7ye/VrD0CxAU8DIBKeFE5wJE4Gn0
 fFLrhyaTPqrxU5v+Y2hwprz5aWShC+ejltknJ8jkaFdOTv87ysUN7rCo6o529Sg5GRRpGYKOFgV
 6KH9V8QMUnG9LCMR+SnvFxBQb0LE3zvl3RoCdKIZ+xWX2yeAIEsiwpq+PHppjBQIIIYEKHyo0iv
 sniy1wmtTNZeKy+OvQPk+b8nRskzHclH1B9Q+WBXubP5eGgBRnjlXhyxv4vmRwMd+6JdTC8NNhq
 m/GF0/d7Kes75/A=
X-Received: by 2002:a05:600c:83cd:b0:49e:6806:5712 with SMTP id
 5b1f17b1804b1-49fc7ddb90emr15837745e9.2.1789725967027; 
 Fri, 18 Sep 2026 03:06:07 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B829B006E521A2A508563A3.dsl.pool.telekom.hu.
 [2001:4c4e:1b82:9b00:6e52:1a2a:5085:63a3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4871ff3a8easm2922671f8f.9.2026.09.18.03.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 03:06:06 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Igor Paunovic <royalnet026@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Nicolas Dufresne <nicolas@ndufresne.ca>,
 Jonas Karlman <jonas@kwiboo.se>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] accel/rocket: DVFS for the RK3588 NPU
Date: Fri, 18 Sep 2026 12:05:43 +0200
Message-ID: <20260918100543.23974-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904130858.27803-1-royalnet026@gmail.com>
References: <20260904130858.27803-1-royalnet026@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Tomeu,

A gentle ping on this series, two weeks on.

Conor acked 2/7, and Nicolas's review of 3/7 means a v2 is due.
Sashiko could not apply the series, for the reason you gave Jiaxing
on 31 August: its prerequisite, the slot-search fix (link below),
is not part of it. With that fix first, the series still applies to
today's drm-misc-next without conflicts (git am only, no build).

I can send v2 with the fix bundled in, so Sashiko can review it,
or wait for your comments first, whichever you prefer.

An LLM helped me draft this mail.

Thanks,
Igor

https://lore.kernel.org/r/20260904125936.26234-1-royalnet026@gmail.com

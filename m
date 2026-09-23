Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC152C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 19:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2FEC10E390;
	Wed, 23 Sep 2026 19:55:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g70n/dXC";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C1A910E390
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 19:55:00 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4838dbf1bbeso164312f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 12:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790193299; x=1790798099; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tLk6o6UAGSAyPrMGXPvZEKdQLnv1x/FQZrjKDEESrwE=;
 b=g70n/dXC3Mj8XQ5ZaMIyERplw/+R2Nv78cccK9hFXH7BTx9SZ+S6LQX44RtNHnDgKy
 8+D/gjpUNw81Dj1oYvVSTMHuu9I3Xuy3LA6ANAFcHOLIM+5pzsRVGJhT5UZCFVg8Ne3I
 YrAj72u835JBtMxeIsswGR/BMdhs5kl5cVl+5/qh2r14tU5/dzq2IxbWIXncpfs+lZs0
 ipENkA0ba54iq+2tNinx46C1AoUI95AmT3GSDq3nOW5DWMcV75p/BonyCxOcZygQ2gis
 v89aZLGSEDMvINNHDDb/IUNjRMUGLEW/MkWqcskECHbOAehwu9G1Jw+aunBRDhZ8a3Mh
 Vffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790193299; x=1790798099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tLk6o6UAGSAyPrMGXPvZEKdQLnv1x/FQZrjKDEESrwE=;
 b=x7cVI+hkrDHareOMatWr+Lvg9ywUGOqyX3ReMsoVOCgO4JENcr0R1rYaQ4Jy6lBQwb
 u9U6a65AsU2ZMV9zFJubGQddOT9c8/MBv/PF7HWE5AVia7bn8w5OL58ukQ8fLF1dBo5F
 Qf66/eQ2WAaFC3vQcEMJh9nq65lQD7LQ35grJR3AJeES241SwfLEtjwqhGCHeV7YRVWc
 3QvQMkYxryhgNGjxnbtn9Owk7uj2runMs15KtQ9eTAXZNCTdEJ8mPUmy8VU6Qp3VpV8W
 +yDM13YFbq5SxHPazPrDNnFlUHTI5Zd9DTyEAxtAUrT8BJVYbFAxB1XMJ/S26Nw4X4ak
 nTBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjtyCiprgaUrJ4gJaLmzGrr8J4Dbhmi4PGAEjNQpsoVSninX2W2Q1pw5zT4b19u02DWUc7REBfYI0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nWoCHiCrGNxH3x4zwWRY2Zb5Sb3LIt7DxsXIwdWTVLJkXAdrzW
 31G5K5B9we6Zs2RP66Z73tqZhiIKcS29nstaQg/7C/vwK/MqnOHdFKVB
X-Gm-Gg: AYBFou0JY4R5m+CXbPTr2kDFqq2HVARIroY7KnZ7dKDDlSaWpNYm3bKu3wqa2ZSdxKT
 S20klTW6AUDoekJ+0V6heO3NNbnVeWFDr6v1vwdAOUeqNqNnXrD16O3EjjgNwSBzJmyR7uuhyDu
 gTJsy5qLZupaWA3N/ljWfDbQFUJeM4dRQZVyJgBV7LH4RpNygHStX/AgewWyhuSq7UI4utkZLww
 iG5HzaBKtW+a7Xf4GE4YeGohhm1U6lypRGLVXfmof2fhe5XmYv6RyyxpMw7t5UxVcg7V+EerXwZ
 puT1MEMV+i8SgxnKtcvKgHaR2tdAycD0ym/+OEhJSVJbR7m1oEp6acod2jfaQ0xBBXGO0ZubyJr
 rcV6E3zmGKgR8a/wPxSPnq8RQNKvZwEt5BB6CC5JaqYdEnXIgRoODdGt9ghD6YWf++011vEYnVL
 JpgYnSXpqTtytRY88CEAz7gFmPg1169uA8nrQvm+JeTP7he3BTWFaCMDOwuhnLGNr38mxhJz+1l
 X88nmzal6SnEVWTqijFGVwZLkrRlN5xInd7dA4XS8KMlXVhLTtCYw6e4aOtCA2gzI1miYwmXQ==
X-Received: by 2002:a05:6000:2083:b0:487:a9f:4fa2 with SMTP id
 ffacd0b85a97d-488716ef593mr320372f8f.1.1790193298626; 
 Wed, 23 Sep 2026 12:54:58 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8F4500007AAF7E1F4D006B.dsl.pool.telekom.hu.
 [2001:4c4e:1b8f:4500:7a:af7e:1f4d:6b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488688856f0sm8592627f8f.30.2026.09.23.12.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 12:54:58 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Jonas Karlman <jonas@kwiboo.se>,
 Guangshuo Li <lgs201920130244@gmail.com>,
 =?UTF-8?q?H=C3=BCseyin=20BIYIK?= <boogiepop@gmx.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] accel/rocket: DVFS for the RK3588 NPU
Date: Wed, 23 Sep 2026 21:54:23 +0200
Message-ID: <20260923195423.10244-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <9cc5365470490b4b66364e60fb614ccda7e86c6f.camel@ndufresne.ca>
References: <20260922080114.44662-1-royalnet026@gmail.com>
 <9cc5365470490b4b66364e60fb614ccda7e86c6f.camel@ndufresne.ca>
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

On Wed, Sep 23, 2026 at 03:29:49PM -0400, Nicolas Dufresne wrote:
> In future series or update, can you use common formatting in the future, I find
> your changelog hard to read. Do something like:
>
>   Since v1:
>    - Changed patch X with action Z
>    - Fix blabla
>    - ...
>
> Its actually good to be more concise in your communication, "wall of text" are
> difficult to cope with for maintainers.

Thanks, noted. The v3 cover will carry a "Since v2:" list, one line
per change, and will be shorter overall.

Igor

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDF5C982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 09:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1A8910E87D;
	Wed, 23 Sep 2026 09:44:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hY1CTUDq";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07F4210E87D
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 09:44:10 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4838dbf1bbeso85890f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 02:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790156648; x=1790761448; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F4OSOZ6QNkL9RkPJ9OENWBp9oqWXQ7z1vT7cr50A03I=;
 b=hY1CTUDqC0E7isujDAEayqDfPYXnW/C/mkoyufvVCirANK6mk+z+74jtlZ6tn3lsRe
 hc+FEBH361SJ2J5NN5XrRO0enhJ9RQfI8KnW4EroJ1d1FbJW3vIhTBgvxuhE8Kqc7izE
 foHEQQLgoF1YnHNi0V5n2WaawceOSdPahdPZQ2Z/1ktUctSxTnyChMaaw7dhQKfjwOYz
 xB1mTwiqu3SGfLel107iGQ12Cy1CM588OQh4P3LfIXcRDkGfpzQM50vO5ygxipfCLwxB
 LgkUZN673V/SXe+/szb64qZ+SJg2Zfx29D5vX1w0qP8YPYz4ZNnozAQzasiEEtRDY4Pe
 sicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790156648; x=1790761448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F4OSOZ6QNkL9RkPJ9OENWBp9oqWXQ7z1vT7cr50A03I=;
 b=xytZRzVfTQT37OQW6kGqRTD+pJ+tlYaSsfLMOGLyz3iNTE51rMJ/UP6TTAizzGQlQz
 vN+2wws8vUL33W20wAyng1M8aDR2b39VHC2jkkoDvIuejacvFgKKvRpi2F0JzRzodssx
 pWW8zNd2XN4Q4mtmMw4e+k6IhqVkHyAC/6UsWqV0H8+qvwmnpPe5OaUBAPqD6ACWVGIc
 wRiguY2r+ag86yTO7Q7EWFOd6xjrvMHYvfa8XjXzhnicrusQTgeT8VQDZ3vj2PGqczNx
 oja29LfNSmV2us7sep8DeH94Xf53LhYCR+rtPWbm/rQ6+si+Ej8+bJKsnzwzBD6lKCVk
 kUIw==
X-Forwarded-Encrypted: i=1;
 AKwUvByKbabuOhaFaNor5WmZP6lwq10ttJCkfnJ5PWI30EwlTCISyvPbb9EtEj03hc9JaVqRwWCAR6Vz288=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mbaJ2EucACFzgqlDKuNH0RM7WepWEsZoqAJOwmmZl349ScFQ68
 +8MYG05n0EGG8k0ydoW9+9R9UAZwbu6Zd/g9BRiAb6yBhXWoyQFeHzTW
X-Gm-Gg: AYBFou2fD4tJqMcoAWDgEDpg0kXRWuV8u3Fm6KzB7XlVpjNs2oo3HhJxgWi9EUct/Vk
 ECxeJtq8veJ+BjaoK7ernAGn5m6PK93CgAs0h18+aJDPY91kw6MR1cnX2Cs9mGRYK5m6v46QqKw
 2xFzZJgvksy4/JZf9qpOegx9Zer7akjSw+11GHjUJRKLG6DjdDa+RNeDR4VTpTghTGbUVCMa4Vy
 nPJvSLXcBapd/JlB3U1n5KF35/L3Xa5JrnLlLlntT+m5kp7StM1J7oTMqhUlS/73S8RNE+nFHEs
 /Y45nZ9WooMrPHLOUKElkF5HpBRhy3K2MhyU0RrftMoxfML9lCaGH/A0om5U6nd549TejcLFXug
 DqQg//k1SBFDekbaJh0OtiJlvgpnys+5YaJLr+nEJ/6NdN3Uiww/tG8E+yYCkIt96s9hmjf9Olz
 DGqrRuSb4MPfRIbM/zjID2DFEzuggTGjPOse78Mtrf5B6hVbKZ2aTj3wzlngg496RMHG6Tlv7pF
 ZEHJ5HM2lpcLx0lvQgyhpAVb2+G2EKRepV/SslE+eqQ4vhMBiXzMxG5gOEtnIhv8akwYDuKL1z6
 bsc=
X-Received: by 2002:a05:6000:41c2:b0:487:240f:b0b6 with SMTP id
 ffacd0b85a97d-48866fec88emr3319246f8f.0.1790156648286; 
 Wed, 23 Sep 2026 02:44:08 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8F4500D949869966507951.dsl.pool.telekom.hu.
 [2001:4c4e:1b8f:4500:d949:8699:6650:7951])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48867b49661sm5535223f8f.0.2026.09.23.02.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 02:44:07 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Diederik de Haas <diederik@cknow-tech.com>, Rob Herring <robh@kernel.org>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Nicolas Dufresne <nicolas@ndufresne.ca>,
 Jonas Karlman <jonas@kwiboo.se>, Guangshuo Li <lgs201920130244@gmail.com>,
 =?UTF-8?q?H=C3=BCseyin=20BIYIK?= <boogiepop@gmx.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/11] dt-bindings: npu: rockchip: allow DVFS and
 thermal properties
Date: Wed, 23 Sep 2026 11:43:53 +0200
Message-ID: <20260923094353.20318-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <DLMKYI79QQRS.28Q4ESQ974BU@cknow-tech.com>
References: <20260922080114.44662-1-royalnet026@gmail.com>
 <20260922080114.44662-7-royalnet026@gmail.com>
 <20260922160602.GA3529337-robh@kernel.org>
 <20260923085755.16219-1-royalnet026@gmail.com>
 <DLMKYI79QQRS.28Q4ESQ974BU@cknow-tech.com>
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

On Wed, Sep 23, 2026 at 11:15:22AM +0200, Diederik de Haas wrote:
> On Wed Sep 23, 2026 at 10:57 AM CEST, Igor Paunovic wrote:
> > Will do in v3. By the same reasoning I will drop 'dtbs_check' from the
> > two DTS patches, 07/11 and 11/11.
>
> Doesn't the same apply to 'checkpatch' as well?

Yes, it does, so it goes too. In v3 the trailer will only name sparse,
on the patches where it was used, and the DT patches will carry a bare
'Assisted-by: LLM'.

Igor

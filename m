Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D3AC98315
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3920D10F33D;
	Thu, 24 Sep 2026 07:36:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DCYm2mlD";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B67FA10F33D
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 07:36:28 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843178b1c8so216374f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 00:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790235387; x=1790840187; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pQGSUWP+wqeItZ/eyVbalLMbvY0OTH5QJikLeqmKP+Y=;
 b=DCYm2mlDEZoqrvoZ+Tm4LMGewusPBFdBF9F89/LRioOIOFAATYWfPuiutyxVTZsz8N
 lmkIoLa1UWpT4mrB0DtoSH4r5Vw+jH28IRnurOqkToIZ7o32w7MuNFuR2qVeuHpfIkaL
 /chINQ2n0EHL/89QSbHrFq8LMf0zfd/Wp5yWs/2+VFhMZSjcwPvyO9uG5P89fQ6xvLL+
 UE1pDWNwtn79YDU7g+3oRFDNistimOW4TpxTWdxoub26+XrcvKUDn6IsE5jCucdMNXez
 TstFKM9xKK0O0CwSuBVulnu/lGeiIiQHHP+Jp8TMizZSxEEQkNydCxIVbxoboLhSKTYm
 TYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790235387; x=1790840187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pQGSUWP+wqeItZ/eyVbalLMbvY0OTH5QJikLeqmKP+Y=;
 b=xofyrUcmV3vfatG5tkWR+7/NyibdIH9NU0NLys+qVw4LJC4CxbRSUP2N9O4lB5dzTv
 KyJbrBZvsJ8UF3FtZ/sHz0XU8oTYvbjm2UfVPV+Q3DIOXfgv638+nHssWZ5zF38Uj6ut
 xtDqVV8ts+uUJmeimaujZDI63xmO3jNm3pDyMuj10Qw1bGG8uRV1vscLXSpRsF3zaYPK
 c4MkTER4XJSHhfrWyTLs4wHbqIyzuHsuIAEk28RZZwF4YIfMbvQtCgksobXaUdOV7838
 17WCQhhx85UcHuwSOs8Jw1QxLogH0y8tLZrV28d4fL47UZuJd4TUnJwPv2qNwrJ6luUL
 KEWg==
X-Forwarded-Encrypted: i=1;
 AKwUvByfvOr31ScCLiJ+/aqt7yusUIu8YEf6cNX7FdyPMern3nKnglXnbCRwQLqQ1QZAp7rFtkgprgpr+1o=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lPdHl3WdT0bskS+6AqHO/6GSFeu5MIBp+uW/q0w22zIcnCL+md
 fNHt/PkAw2e4WvFH8ZluZN+WTv6dx/XbR57vE3TqqtbpVRsU1y8ApSFl
X-Gm-Gg: AYBFou0njy1dbNFR6BmG04RQgaMU1Oh0q+P2lIQHZZyCKFtgqyKlXrNgFPJV/053YGs
 x3kZSy2fAq1rZZWLHThu5wz5RcwILIzU20kxi/iuWf5xQB1kiQBZqBAuJigTwXQt8uLWMwVh+F5
 hJjqxUnyMA/2MI1iXgCvMMkFsYAMizk/bruB0D6RfSNrAzuOTkLuevNErbJJ2OsGL2otiauIGAZ
 ORZoSLzIdJYZINsaFBO5wlXh+yKE9yejdU9CKh7fmixFO+r3SyMVgUIOmCgTINx9vM8haosyOts
 kMnMBSI7f/3b2qT9WBcvrb5x63DtGgdmQtg+zU2unPbTlOOXYm499SGGsr/zrSAswXsj/xjIXzk
 6qUlQD9wQbAaCE0pO04Mr1sAL7lsp9D8qQ/TN0dXbGUfY0lTmsQhwOt7cQvEZwm2aIHaOyIkKIm
 PvTOZ8tLsLqqwi4EcDTNY43cAGcZU8azkfNv8jO/rQGLZ9cz3D9xf/70I9m3b7y78VmlZTspDWB
 JaDski009f75mHua8t6yJbr0nHp6XhGD2fS0Bfgfytab4KToPf5VWIMx1KKmJ5WvX64m51hdeMo
 VTU=
X-Received: by 2002:a05:6000:25ee:b0:487:342:d145 with SMTP id
 ffacd0b85a97d-488716c8044mr2252224f8f.2.1790235386830; 
 Thu, 24 Sep 2026 00:36:26 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B90C500C183EA9C12FF3B42.dsl.pool.telekom.hu.
 [2001:4c4e:1b90:c500:c183:ea9c:12ff:3b42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886877970fsm12839361f8f.24.2026.09.24.00.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 00:36:26 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Nicolas Dufresne <nicolas@ndufresne.ca>, Oded Gabbay <ogabbay@kernel.org>,
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
Date: Thu, 24 Sep 2026 09:36:06 +0200
Message-ID: <20260924073606.45849-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAPsqS2SC1GvzALUdf2xsHZDpNjDO7BXrmzk19OYTF6YopQc8iw@mail.gmail.com>
References: <20260922080114.44662-1-royalnet026@gmail.com>
 <9cc5365470490b4b66364e60fb614ccda7e86c6f.camel@ndufresne.ca>
 <CAPsqS2SC1GvzALUdf2xsHZDpNjDO7BXrmzk19OYTF6YopQc8iw@mail.gmail.com>
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

On Thu, Sep 24, 2026 at 07:37:04AM +0200, Tomeu Vizoso wrote:
> I will go a bit further and recommend you to not let the LLM write any
> text at all that is to be consumed by humans. If you don't feel
> confident in your English, you can ask it to correct and improve your
> text. Or write it in your mother language and ask it to translate.

Thank you, Tomeu and Nicolas.

Yes, it is true that reading and writing in English is hard for me
(speaking is a little better than reading and writing). I understood
your message, and thank you for the advice. I have already applied
it to this reply: I wrote it in my mother language, and an LLM
translated it into English and corrected it.

In future replies I will always say when an LLM or Google has
translated my text and corrected my grammar and spelling mistakes.

Thank you, and kind regards,
Igor Paunovic

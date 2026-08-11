Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A5BC5AD55
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 02:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 906DA10E268;
	Tue, 11 Aug 2026 02:08:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="JlUTAAg7";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="IG8kQt2D";
	dkim-atps=neutral
Received: from flow-b6-smtp.messagingengine.com
 (flow-b6-smtp.messagingengine.com [202.12.124.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C0A110E268
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 02:08:16 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailflow.stl.internal (Postfix) with ESMTP id D263E130008F;
 Mon, 10 Aug 2026 22:08:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 10 Aug 2026 22:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1786414094; x=
 1786417694; bh=rWm9RHbtzazf993VOPOsupHPiD1NvDkD8ms+u6UxPHc=; b=J
 lUTAAg7ypbKUVWXMw62mJurmR9MhUq5rfmwaNndjWP6fTJvnCfeayGTgFXHIbzny
 HsqewVInRovsf4hYMlAn/7J9YXHICXBLAPoCR6xu6wD/pSFYVyVCQIPvuCv4nAiK
 PNUrT303GsDCyw3rnTEOzYnJSG7IKS+y+CkDstvGYNxtI7E5Ru+yDQuDzhcYAVLi
 jaSrYdBxYeXN+y6ZXd8rC8jBB7f3u18+zJuBD9phBaxietgdq0e6FPDlqiPFUkww
 kBW4esosI5oRd8wev15if3ngh+Y56XAd6ST1+PQ/wUpZbhCcZwausbHseaaNBOyb
 LoPrDf3CbhxmwKj4xd0cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1786414094; x=1786417694; bh=r
 Wm9RHbtzazf993VOPOsupHPiD1NvDkD8ms+u6UxPHc=; b=IG8kQt2DXynm+w/82
 +vPHRp02FIYGa7Uh9BCLaaf7VGJMq7Jry8Di0R+f8DaUh2m0p7iV5wTDtzxDbPFE
 ii683faabUgyR1sCWyxoCrsHN1oCZDHzg4HGw6aXJTsZyMdzQqrbW0yfz6yLH4rq
 8eghTC/Pa6W/6iFYJMfzFGMa6Vr1lob3SEDjpMyA9DXVQwJ10waGt1t4QLHEw5ZC
 D9qfPcqmBfTrZai1qeDOBicsdWjtRT8UsuydHZUE49i4+Vzv1MDcMlsqZMQIB8Bs
 k8nTfqnuXLvUO+4s3oOpzasZ4O+MoQNEsT+o4KdsC4kY4G8LbamswqpXstY1zf5+
 IHVdw==
X-ME-Sender: <xms:DoR6alQWd_KRZ3ungJaulrfVDtU8Kk3T65C73QJ6mnn7Vc1yqB-iog>
 <xme:DoR6alJ4nvrM2IbupZG-8CE-nicjJaGClXc7ANA-bOfcyqhL0I1qpvhaUqGV6z97A
 kSKj3JJGb2AEoHRx-xxMQnWKFzIUIld26cBvpVypgJ7kCcZwDWf5oM>
X-ME-Received: <xmr:DoR6anEIG5pz-PsQyA6pitWcoGARlynUHaBRH6Jx1s0xrwP4vgMZc1eutW7cer0r5zmD4AtXow>
X-ME-Proxy-Cause: dmFkZTERbI1xbd5afPRWYP3f2skAMeglpOkczslCfBYcEYR3djMQW1qlWyWV/djaOiLGyB
 jCqnT/qEQac9T+QQxqLt0cOIA598/BpHvO5omQCz3QbUsbNxGDGcCubRIfrxy4hpvIhjct
 TW8FkzIdmi01QffYDmEb+MjTyO4pkSV+l8JoM08XDklG8EPPcc54YdVzBpusM91cNaToE2
 Qvld2OMSe6kPDjEmkESLxjAFOAH24FisU5Ut9KwCYj4zPUxBGKl/Q1SU7YU4QS/fpya02c
 2tn8jX0JUWNKiJRSx+jUM4x0hU9rJ6qB0gX5QZB9cNvKFCAtjRI1z0L8U4oEUppb0sossh
 49XfuwWqudVJ5zPnObaG4tO5rE+cRooRkUgQrnVj6KeRVZ8G1A5RySKbCS9lDLzVZ2WyEZ
 kAmeAUbRtTwW3uVf+w8QOo21fyX0npTD1rRsdb1y1oVSUZoqJNuf6MmQu6J9bxf81uqQE7
 X7zRm3FXGnzrLocmt356t8g/cc5tDeo72/HTHKa34MyXyhu3xAOExKE0h5w/6YWEwCtnY/
 dAkDQmJ9Sj0tdVbqBelIAPDjE+aGe/sVsmMVXWRQ6tI9/IMT3qrcIyUwX+cZ0gvgg+4URK
 I0itSAPlUCR9AOFVC3ZM1peWnlXxOL/Q4WCWlRzhtxZ24yazYQwkYRWT+vKg
X-ME-Proxy: <xmx:DoR6aq29sRK-sM1KhiqLDMXFjEacxMPwzCzV1IisE2HQQv77i_SmvA>
 <xmx:DoR6anI7fSBaa3B5kz4JI4mow_ko-p9UTYGhvErYG0hF2dIzDwZn2g>
 <xmx:DoR6an0HfQ-zkE49LsbD3I8PU0-5MMwpww_c3ISVazNw-OMsHRXi7Q>
 <xmx:DoR6ajlhILSYjctLT-HLA81qdImd5ZE0G3bpIj3J6F6ubrL6_F5E1A>
 <xmx:DoR6ao89ArTV7tWdcNp-ae8-pqmQ1ExxdCrH-eX-Dqi9v2q0h6DjAzVh>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 22:08:10 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: chaoyi.chen@rock-chips.com, royalnet026@gmail.com, heiko@sntech.de,
 tomeu@tomeuvizoso.net, robin.murphy@arm.com, diederik@cknow-tech.com
Cc: alchark@flipper.net, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>
Subject: Re: [RFC PATCH v6 7/9] accel/rocket: add RK3576 NPU (RKNN) support
Date: Tue, 11 Aug 2026 14:08:07 +1200
Message-ID: <20260811020807.1605238-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4f300b78-d96d-4d98-8819-dc292b0c9b97@rock-chips.com>
References: <20260806063413.350184-1-gahing@gahingwoo.com>
 <20260806063413.350184-8-gahing@gahingwoo.com>
 <20260807211629.1573228-1-gahing@gahingwoo.com>
 <4f300b78-d96d-4d98-8819-dc292b0c9b97@rock-chips.com>
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

Hi Chaoyi,

> I think it should be for every submit. That is, when you set
> task_count_clear, you should also set task_last_layer_clear at the same
> time.

That is what the driver does, and now it does it on purpose rather than by
inheritance. v7 writes

  PC_TASK_CON_TASK_LAST_LAYER_CLEAR |
  PC_TASK_CON_TASK_COUNT_CLEAR |
  PC_TASK_CON_TASK_PP_EN |
  PC_TASK_CON_TASK_NUMBER(n)

per submit, with the three RK3576 bits at 16, 17 and 18 and the RK3588 ones at
12 and 13 beside them.

Thank you for both answers. The layout settles a register this driver had only
been able to reach by comparing traces, and the bit at 18 is one it was setting
without knowing what it was.

Jiaxing

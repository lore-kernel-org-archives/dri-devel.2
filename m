Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C672C624C2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E402E10E6C9;
	Mon, 31 Aug 2026 08:04:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="i8pDxd1H";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="QlY/tOo5";
	dkim-atps=neutral
Received: from flow-a4-smtp.messagingengine.com
 (flow-a4-smtp.messagingengine.com [103.168.172.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58ADD10E6C9
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:04:01 +0000 (UTC)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailflow.phl.internal (Postfix) with ESMTP id 92CB913801BC;
 Mon, 31 Aug 2026 04:04:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Mon, 31 Aug 2026 04:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1788163440; x=
 1788170640; bh=dsm6f3Hxa7PpHhgY5bQojBV20QvcNEc71Hr3FPczx/I=; b=i
 8pDxd1H9p4sPqg1LpBCk0Iz+0xp0HKMnWRFpHneiHzFnYA3NCDAzJui98T0Ml6BQ
 benoAGopiekaPlMg4Xgx+CAJ+8aX8lzS7rnylzwUoAx/FgOOrMCVM+tt9q5/sFU3
 mudHRvWr5K+BWIqDH5zy0xWwnHVes1aA41T6LDdnMfmF53f0b4iNBRbn01tGpbMC
 K4jrwXyJBn/odopMUQ/QDX0Jx1yEoC/5goSUeRoCOamvGdebyi5H84nZQn+Br3o2
 ABxyDgeeY5rb+vlbwfQC7wxDAKBL1c5gDJVBU9e8GthZo12u6uZO+an74licoDcS
 Y3jL0UkxANKLQLxMC7mSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1788163440; x=1788170640; bh=d
 sm6f3Hxa7PpHhgY5bQojBV20QvcNEc71Hr3FPczx/I=; b=QlY/tOo5t3KyH//Ws
 fc6w6Vgo98chiQEhxCvp1kHIzWJz9Cg/DWLHrvpwtphvx6owqSnO/SF4HAGgW1Zx
 tUB4LmstVpsVGw9Fdv8x4jfODvP38FbRdOCgWoPW1z4PRFpoNtNgCoD+XQLuQH2v
 /9jagtf1BHVmjMdfTX0eM+owMvF6gN3UZtER2hM9Ux84hSExjkILE8MOu77ie+Xl
 FGn/x5+5yIuaWmjUsY5tFtt+mh7+vS9Apm0fz0D9wM5HIOFPc6gLIESpv43iXZqh
 K9F9x4ZAnGf6BZ++8WRdeeNGU2nRTnCKOOTWSOxnwzlS6wl/ZFddYD+0qr/Z25YV
 RYQRw==
X-ME-Sender: <xms:cDWVav3NXM7fMXdFslDuDnS5n5tjYROIrMEflys0hYOo5UARqajlfg>
 <xme:cDWVavkscg-J-nZaIUSGgCfFS-UDvGQ4yUuu_gN9jvJKwHkmBrfh6i7NHdSdqvosn
 mayEoddNDa4nktfmZQ0jM7rqOUIdAJIWyXOh9uuo0cG7vghwKE2_g19>
X-ME-Received: <xmr:cDWVav-YpsD0b78i10ClPThYDLVTIO7OmzG4LZuvXg093tnRpJpi0hglhS8DGq85sJdISgDDVw>
X-ME-Proxy-Cause: dmFkZTGwK3R3O+pasDkxiLW1+1sO0SHZLL84GGOeroV06YjTGYyTwjk/GX5FoCR4WIE529
 YYNMm/aeKdHa7ig/EFLlnKNGRRbGtPW+g5WVUxWB47OWDpPu+oupOoLBSW2GysuIx9C7xM
 e+uY1B6gA0ScorGB3Ybd1esKEbEUBBUREQ6BiCEG85SYPu38dLDkfC8i1FkeJuvkfTHoQr
 QmNkkKNwTs4k4uxzYqFCPW0cPiAgcVI29YS9Gxb9iSk2csLJ4ixadk+Ytyk9TC689PySGx
 aIn46hYKQ447LVHHtzJnwe5jsjSlt26Uwkc8WlQ7N/+GDiUndN+ku1G3r2vrcKI7ns9SFL
 rRAIV9idI8m/6Z+WjqRfbG7D13CkIqsqPz74DN2HBuhPzDC7aMBrFfb/pDfR0sbVyJROIj
 vnNjW0PafJrKTfkiwrdQm8EIzGIUxpJQBznrGxIWbgwk/k9PIO/mrAzYVLCB1jCuLiDuGw
 uOe7vI1E64dctkEXUvj5Cv6ncTmdPnneT6PFYRGgYNfDKI04m5HNigJ1j4LqavHky6gBRM
 ngNkzy1NpdqBSvR47cVEjzz1u9wZ3cBkNO61iOyLWNIoLjt0/1f1Y+0iKziCrBUUsMK471
 oMQ0/xUvenSPPJ/zWQpEEhzFTTq0++Rb9/pXlu7POyo3DVW+MGfisld+KOvQ
X-ME-Proxy: <xmx:cDWVakqYdOWUja6sj_4HFdjPLCOI824KVTdGdwoFSXW8LVjrRDfI7g>
 <xmx:cDWVaomb6FlJzwXzVZKRcqeaFezE9I2mqblQ6DTXH_2rUasE0jNY2w>
 <xmx:cDWVariQhGu70IwKtbN9HBWRQ-cNxFjI59S5YyiUOtE8AUJYj_kUBg>
 <xmx:cDWVagdJ2iOl5RWoVaViCdzJdbxy50yqpluRyhdFwoVW8rAvs7P46w>
 <xmx:cDWVapNG5VDOdD7xZb__4N6jYh_tra-9AqUx7GmJTaICW_TBn74xLvu1>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 04:03:58 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: royalnet026@gmail.com
Cc: linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org,
 tomeu@tomeuvizoso.net
Subject: Re: [PATCH v2] accel/rocket: request the core clocks by name
Date: Mon, 31 Aug 2026 20:03:56 +1200
Message-ID: <20260831080356.80952-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729130743.128876-1-royalnet026@gmail.com>
References: <20260729130743.128876-1-royalnet026@gmail.com>
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

Hi Igor,

Heads up before you see this patch arrive as 01/14 of my series.

Tomeu asked for it on the v10 cover:

  "Sashiko is not reviewing this series because it doesn't not understand
   yet prerequisite-patch-id. Can you please resubmit the series with
   Igor's (presumably) patches bundled in it?"

So v11 carries it as 01/14. Unchanged, under your name, your Signed-off-by
first and mine underneath as the person passing it on, with the four tags
it has collected.

Regards,
Jiaxing

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9EFC5B572
	for <dri-devel@archiver.kernel.org>; Sat, 22 Aug 2026 10:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C3E310E18A;
	Sat, 22 Aug 2026 10:10:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="ip7TpOJ9";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="X/Mbk6VE";
	dkim-atps=neutral
Received: from flow-a3-smtp.messagingengine.com
 (flow-a3-smtp.messagingengine.com [103.168.172.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCB1010E18A
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 10:10:06 +0000 (UTC)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailflow.phl.internal (Postfix) with ESMTP id E73B21380161;
 Sat, 22 Aug 2026 06:10:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Sat, 22 Aug 2026 06:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1787393405; x=
 1787397005; bh=YMoogVRYIwk8Wptzr/Oo7EUpCyIlUtkJVK+72BZkIEk=; b=i
 p7TpOJ9TyXg8JbynvoR5GTVIYShXzyttF7tdrWMJCmhbG3pMIjYpYlnTtkv2Udsa
 hr1fJABNDI9TWYKdDeqUN26znpzqP+aMgiX9SoBIaQ77wphDts1KyGh0KB3PtFxi
 ESEYrqr8TDrSGZgFYaGukmg46blFshcTaIbBbKljyJ/XLagm4nlM1RPmxEaHhI8a
 1A71VzS9LLDYnS2PAkSqlC0gsFAvimjHeUY4711AxPap8jiF/1tkwTPY+uNoijbY
 MroiuXfIOARxLxRw0UaOaYQ8e2By0gW4bTdnlf/RvFltfanNgjg1jRiK5iuHLGLO
 TTocKuIcbi6jCiDubheaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1787393405; x=1787397005; bh=Y
 MoogVRYIwk8Wptzr/Oo7EUpCyIlUtkJVK+72BZkIEk=; b=X/Mbk6VE+ENJTaU+z
 5IQirWGDXrtUCv97wArsTuljfZeOMQm49NbM9dw6AXptiIoouPk5WrVqBylNRTq1
 7qrHp2LECfcGafGSbHsGtZ/hac1lCMxy5aepIkpQnnqH1pprvjen5+RK5Y7SHldU
 uGXJPx+VVYXQ1/veGgKssvc3percQZwbLuNwvtrLVbY8kOx6sknIoO5JNK5vsPU9
 nzQt/cbjEF3B/ZE1C+9A851XOdDgvchQjz8wxTgYW5z1zKb75Au6VbHS8Zu/dpk2
 WfM+7Wo6TQch5WNOTDsYpzy7WZG9+Bb9xduFQYzeLP6dOMaU+zNaPzZ+N90EZwS8
 OKbiA==
X-ME-Sender: <xms:fHWJapdgHgrS_SnP1MLC-YitW2OuDFp0xXgWJ9iDVo9dm_TctDFp2w>
 <xme:fHWJavbaXFnTvZ6cr344qVzBkOUd_LAZXsDQ7iAENxC4VWYboUnVN-TZ5ByHMSMzk
 e0UzoaAEX6Vgo0BxIBd7jB8TdLN23M_4ZKbD9SOeCnntIAUnswT-cgF>
X-ME-Received: <xmr:fHWJauEAhTF_fDE8yPBVewTUp6HC3rZP4SIvUNtSpgX1BAV8zs6_fKySFPPX1zbOCsrvk0Yn1A>
X-ME-Proxy-Cause: dmFkZTGBWdQTFj4HdlU6ENZ1CLSznPDgvJlHM1i8OZX2pVdBj6E3SlQbz5ofJjhRLtzwdL
 odMhyxzcECGNY8afaO8wGltEZEln4E3CTNc0ty1akhBimzcxuGJLqd2VUDO30PNO0dZ6rt
 HXiHeO0r/GLHUCDWxRvnwzLqo1AP/zDqjGHTbd9hktWngEeIEmZvz/5PX7WN7391i+3QSh
 GgJrjllKXTBmxQ45km0dDLQKO195mMeIkX/Qm/H1wJJBTcttcXfVyYRzCZzbyxM0Ob2VJ3
 wLvOtl3Pkn8vfACC/f5w8rs51cB3r0D+zlKMjzopcXHbEtUSeSr2C/ILjtVBnaK7pIF5ZL
 +gtXVvELHMhYaQs/Psdfg8IOl/efEp8vS6Rc8rb3w/rttdCmMBIGhLaHyhsq54yXL/2Uif
 0+N/FUvNWXE37Wu+UCfGghoRDKCNGNq4DZb6cWnXiyD3KItZvzVUQXLtngTyxhLqr8rs63
 BC0h73a3JbhWInbNsAgFoiCwNincOnFjTwQE3TS54nC76ucshwByBGaMfiNDVAWVWIJBAa
 QEzSqEwlMAeLIqKfZgAxLHrxMlOw0WWkZUShFOPduv1jZPwFxr0bz11aSfyneCxzLA4UbI
 DKKqIKKIJZwb1RjIdwtsDVyXfbG7RElDJ1a1G+0MlqQjW1ICRNXdM9us31tg
X-ME-Proxy: <xmx:fHWJatkLUOTDahuC06Roe7CPeyqAIBzXW7vd_FIaIsbC2akI79Iy2g>
 <xmx:fHWJahdFFDK6QgbmR-Pv9BAxuS4zpSKBwvrrdPbHlzO_qo-ucOlkGQ>
 <xmx:fHWJarHnzCIjnoYgYgnljNR5FdCJecRt32EvJjoSM0tr7lMSQN-_Ng>
 <xmx:fHWJanjHXs55tp5LbyFs9PE2_XesfskU6ZIf-tGQovlIm8fcK7YtCQ>
 <xmx:fXWJamPYaeKTZxFiNwYwF_4xaG-9iyx4xh1IlcdhAFvYcz5anq3fdmcl>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Aug 2026 06:10:00 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: royalnet026@gmail.com
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, chaoyi.chen@rock-chips.com,
 alchark@flipper.net, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/10] accel/rocket: add RK3576 NPU (RKNN) support
Date: Sat, 22 Aug 2026 22:09:56 +1200
Message-ID: <20260822100956.636407-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820185056.20643-1-royalnet026@gmail.com>
References: <20260820185056.20643-1-royalnet026@gmail.com>
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

SIZE_E_1 stays at 0 and the diff stays as it is. Your reason is better than the
one I would have given: a register built from the trace with one field swapped
to upstream's value is a configuration nothing has ever run.

I crossed SIZE_E_1 with the channel count, seven values, with the control beside
each one in the same boot:

    N                      16   24   32   40   48   56   64
    SIZE_E_1 = 1  written  16   24   32   40   48   56   64
                  correct  16   24   32   40   48   56   64
    SIZE_E_1 = 0  written   8   24   32   40   48   56   64
                  correct   8   24   32   40   48   56   64

Six of the seven are identical. At N = 16 they are not: upstream's 0 asks for
sixteen channels and delivers eight, in both the words written and the count
that comes out correct.

So your conservative choice is right, and one shape in seven is what two shapes
could never have found.

Two corrections I owe you. The first version of this reply said I had not run
the cross sweep, and I had; the round is named after you. And I nearly handed
you an old floor(n/16)*16 shortfall as a possible SIZE_E_1 effect, but the
traced value writes all 24 at N = 24 in this round too, so that one belongs to
the channel count register and not to this field.

Separately, on the int4 path at 64 output channels, SIZE_E_2 moves the words the
block writes but not the channels it computes:

    SIZE_E_2       1    2    3
    words written  32   36   40

and the correct count stayed at 32 in all three. Additive in fours, not in
sixteens, which does not sit well with the semantics I sent you on the 17th. It
is a different register value on a different precision, so it does not refute
the reading for the path it was read from, and I am not going to pretend it
supports it either.

The re-run offer is noted and I will take it when v9 goes. Glad the trip was
fine, and I hope the countryside is treating the board well.

Regards,
Jiaxing

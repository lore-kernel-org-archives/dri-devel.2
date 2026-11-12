Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40E5606A8AE
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 07:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=tF0F9SoA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=yaqfQY0d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BEC110E17E;
	Thu, 12 Nov 2026 07:22:12 +0000 (UTC)
Received: from flow-a7-smtp.messagingengine.com
 (flow-a7-smtp.messagingengine.com [103.168.172.142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64EB110E17E
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 07:22:00 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailflow.phl.internal (Postfix) with ESMTP id C40591380205
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 02:21:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Thu, 12 Nov 2026 02:21:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1794468118; x=
 1794475318; bh=bJ8bCP6CSgwTUoA5Jdtpfv6fl23Ll6VoeGU8ytMkhDI=; b=t
 F0F9SoAH6M1Jmttn0BNFQF6wa/hS9p9c1PyA9ks+/9eTHeBsYHoJArnY8GZoYJmS
 /yt/X0KuLwZW8kWuoXS6twE2a0qfyrxXNRGmIdaphZ865Zdsc3syrj9kZLzWgw+F
 lZYQmdNPlh51PXnqyQ29bWm15B32QT+R9hCWFrQ8s52vIZy1+/2O8UlwghbBnMuQ
 c0j24paUuPZJCgxLdNHSSjkc9ntZKe+5wWCRCawK8SFfWsNA7bUdBrv/vBY1fzZU
 eFvxT0bURa0p33j4GkcyGWk3I13JEU+BdF979A0/7Myq9FNoo5FmVJwiTvwfoxXt
 6BTBXgtiZc43W3myuxPig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1794468118; x=1794475318; bh=b
 J8bCP6CSgwTUoA5Jdtpfv6fl23Ll6VoeGU8ytMkhDI=; b=yaqfQY0dFDD/zQDXH
 fa9Wmy5pWzxphmoTfhGWdAY4CWIfBliCgnSSkkMtnn17G1aMwI7E3rnyo+ZZb6wP
 vyw7/y2HogD81EWymm8WAQdzTldcb3b5TpyzbZE8Ln6bTCIJv0WnbrdYlC+I1y0Z
 I8j5UJpRHuAXd2CMjSO8YcVFK7ZkqHvCD70gkc4gaeYN83G1Z17FL5HpNJb5rCi5
 MGeMbL9yS7uwuf0Qt7zwwOvFS2491yr+B04lHPS0lzPH1uiV6YXoBQlFMTTGpKlW
 uSh5RKQ7I1IBQE7DwU9RfdkUlXpRapzbIra1il9YhOSeHT60OJQ81iAike43l4cD
 qU0Dg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794468118; d=gahingwoo.com;
 mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm1:rsa-sha256:RuIPxGx1zmhNgRdvcmf7oLu+/0x6DukdI5cR+zXTOcYs6eH
 A6yjvR9X2WvKb9ZY76SJ84AjbJsvKM7P0oaYMYvTDhy+6TgsXKSOOruXxvhUJGe3
 Q4Qk1WJRYBOacKxpYzSnUH3WCEHOpaDf9UlHFqmRnKjuNWTb0iPBcCeWkQhQBzTh
 5hv/5CqO/70AE4pU6lLPO+/4NvjSoR++GPgEcqQ2w6zrA3r1abBkiCi1C2oXDmbZ
 iD6geAKc+hS6vkdeisFXjnMd6ceEe8nc3PQZ8HnNJceFDwhHUV70sZY8dN2Lap6w
 sqqWh9cSNPqevTq0JbfVzTBrZitku64EyQBAGWQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:xuxAie5g+6iRjBprhGgdJCyhDhMjW7s+lKKHIWO1yd0=:bJ8bCP6CSgwTUoA5Jdtpfv6fl23Ll6VoeGU8ytMkhDI=;
X-ME-Sender: <xms:Fmn1ahqt2i__S3t7VvjOrolKTcZTzWIO9Ft1sy_kHoBpWb2kGnoXAg>
 <xme:Fmn1aqd1uZtVZuZdtUBboJ48SIjUmggzXUZI6xF6StzTUeq8g1Nwwe7kMcI9kVrGZ
 HlkzW7JBsOWynfbajCgqn5rtvqi7k6xBD8ALBgXrwARL1uzcYWXt2c>
X-ME-Received: <xmr:Fmn1anK4LBOxBOc2_iI6ucfoGI7MgN9u_9HzmtYFDfbAMTt22u_pQWU8maFuOP_OWsPnFrf2>
X-ME-Proxy-Cause: dmFkZTFmFrZJuGg63UB/F32b8s4zaNC9XRPHixjcDy/1vRk99j3V/8zr+THDSX7svlTEmy
 4dG1lJL3583nXtEoyQR6vHI3FPNAjfS21CqW0k2k5cqZ6TEkfUZ7yQZP7OGrUeVIb7c94X
 pjCA4kDO/W68xNy+tBda21RUbJBqnVTo13bxuqEK4DXiqGGhK5YkgbNkV1B+oHr7BuxNzL
 6gcR6FSGRDK+sNbEjPHIzQmGts9QCYc0FS6HRQLTfllqbaGvOHcy25AxQ3fsV8kYeJqbUj
 7tVHvFDs9cT8uJ4rYzEmLPEKorO5JjMbXdlfCstWJmUKho5t5lQxrSvoMeGxIT83vk+OFg
 oymre8z6E++IHi7zKFs6Qov/bFKiB7eSCarIj1JByykDyGDcJIcME12Yuyid7W/v7bSAbB
 LOH4BVqyVHo5cT9cFwsbTTdnL+Uj8eB1IAcwu2L7lR9qYchicjJzG1wi0jgWnMp3BYOoF8
 s76ocnS16UhP8orLeETzE+jzEtLU/P2SI35DjW5ksOmenlWKIlOxz6qp6KjvKtE8qRhQPR
 /lLUKdbgnrfV2gpx54przCT/IlygE7BcK4fCrGNxtoihP6PuhL6FExioYnjC1pbTtD73rk
 oIBpknCPShTMyBscXFsE6BhYclqKbyrJJ1bMPbn+4dl/f/vS+dWgzzOiT8bg
X-ME-Proxy: <xmx:Fmn1avu_2lSgVeR5VpguZSSSn2NdBdOLsGy0vv1OTRYkrMkpby07cA>
 <xmx:Fmn1alLDs25vhaf8vjWaDnxwwNcVPWkVeLmV1zG1s7SQDYYY7NmBoQ>
 <xmx:Fmn1ajA-jDLtM-goDOvOk1Rthu9AWRrftj3QaUPu21odKhGmARgi1w>
 <xmx:Fmn1aiXXlYQ8-1M-Ks5bixOrYM0T_iA4GAG52_di3rgQGXa6kJVIZA>
 <xmx:Fmn1anUq41PMEbG7seJ1o17fqqnKl6ZIxTtEfJDLEGco-ZB8ZGTAzHtr>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 02:21:48 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: ulf.hansson@oss.qualcomm.com,
	heiko@sntech.de
Cc: finley.xiao@rock-chips.com, shawn.lin@rock-chips.com,
 tomeu@tomeuvizoso.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com, royalnet026@gmail.com,
 abel.vesa@oss.qualcomm.com, sebastian.reichel@collabora.com,
 sidong.yang@furiosa.ai, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net,
 leonard@lausen.nl, jeff.hugo@oss.qualcomm.com, rfoss@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>
Subject: Re: [PATCH v15 00/15] accel/rocket: RK3576 NPU (RKNN) enablement
Date: Thu, 12 Nov 2026 20:21:46 +1300
Message-ID: <20261112072146.41218-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAPx+jO_gRtipR7iuh0D7G2Wi25GZoqFD1JHVbJNmhd1UyC3Bmg@mail.gmail.com>
References: <20261101082307.151957-1-gahing@gahingwoo.com>
 <6777074.j6PcuT4dK6@diego>
 <CAPx+jO_gRtipR7iuh0D7G2Wi25GZoqFD1JHVbJNmhd1UyC3Bmg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks Ulf!

On second thought, I think it would be best to drop patch 7 (the
binding) and patch 10 (the reset) from next. Once patch 10 is gone,
patch 7 is no longer needed either.

Finley Xiao from Rockchip pointed out on v16 that the reset is not
needed, and testing on the current code confirms it:
https://lore.kernel.org/all/ca90a994-70cc-410a-902d-5c4c0aacc9b7@rock-chips.com/

Patch 9 can stay. I will send a separate small patch to fix the delay
table.

Thanks!

Jiaxing

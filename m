Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680C4CCF2C9
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D650210E636;
	Sun, 18 Oct 2026 14:33:20 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E050410E636
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 14:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1792333985; x=1792938785; i=jan.claussen10@web.de;
 bh=z9cQYJmwNkiSw8VAD56sNbdU1SVUzyGJ2BHa5yPF5gI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=fMUdLjYSkv2ZRmyiAa0OXSidzr52kq+T4DWFduwPYSy5M+Q0TBn17/Abkeuv4CTF
 v8SBlmzDbaGoNlfEj39jD3m3fZNgMX5B59kXXFZkhuNpZ/30ypyZ2WSGwc3Ri6xd0
 1DrDb2JgPcCLZWzkoZ8c+d+Bw9hcOYpMtLnT/lwuYqaqdGeY8VaATWKqnqc/oYr/v
 2tkOiPXJ5Vw5Et21Fmx761QSiytoKM6fmMn+6OoFE3itnTvgrvqOsLFXtseYZbfdy
 MIfL+Edra1dZF0vNl7S7O1Wkg1ytssxlEEvM50K4emOH/NO2iSy4qiJiiGmd+ahrk
 06y8Vnr5Vs8RPioiIg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8Bw1-1xErRq10jr-005E39; Sun, 18
 Oct 2026 16:33:05 +0200
From: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/7] drm/rockchip: dw_hdmi_qp: Set the VOP2 color space
 from the connector
Date: Sun, 18 Oct 2026 16:31:12 +0200
Message-ID: <20261018143135.5745-7-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018143135.5745-1-jan.claussen10@web.de>
References: <20261018143135.5745-1-jan.claussen10@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bpJzC5YM2LcnCRb+4GunC/80QcVPck0tw3PJt+Xrsbrb3x6ZAUF
 WRILYMmBo8LjK5GVg/3c8V8urXTc4qvyv56tBYQ6pSd+7LHa+tOTYUAjoIUNXNG5Nv7WlBq
 z20ssOrY52qteMc2x6Rz2JpJ2wrPBHQzQscF/AUUTyYDcrz1S3JCzyY67AxarN2tF4a0IoX
 4Zcmupr6qlBUR8bfq9dDA==
UI-OutboundReport: notjunk:1;M01:P0:xooapds7zsQ=;OzI+58FeJJdYBy5aaZOURUOKOKq
 jtYxmEswFgYdRtdYW+wD73XGyzwfVHycBfpMLefTPo56oolHkwEONn4ZcJI+DAl7mE7hMoI6K
 U/ZyOwNinJVpft03m6uQNtoLoYNZf9mACk3hA0kl0Ld/XtxQMwi8d0Qy3tLGUiN5IgMkC5oZI
 Sd1wziqAUCOV6PKbWvLYMgmwIx9syQ9ysGEN12UPv9PTHkZ1YqAE5aHdxByk4fKVBTHiZHe//
 tEUID/wo94ji24cpHdSv82opj0MLrjKZAqMbFi8Gt20PU1AKw0JZvbfhvoDhZnNl7KbJ0rQ2V
 nZEv4Jy0wPq6y90O7SvHr8u5LOKL8jPoaBgU/XZDJS7akZC2NLyi0PxSon/1GLfh4DG5ake58
 /fAFEcAHN05H73KypNmnSCRSl5AZ4m7uUvFrLWRPOwpDswAFwYfjhMI1G6vIfyRzhG6EMQE+o
 plmTFM7avdRhjojIXcdOIsytjHtwV5i3eO8sLtdKjAJxVN2+DOETrKRE420vX4/AIVoLLzEGy
 i6GgfIsB4dSwSDWdjUEV4BPr5n8TDXWodDdPYsPZ1+DOeqSCvlWu23J4KnGfyil+bBOwiH42c
 nlNODxF36JBkBKemJCuMgTt2ARHWjwN/w7Ls0vGEkeR24QGq/wzZFbR9AbPuCWxNKLnfA1blR
 pPDEJe1TEcIAtPuK7IfAAU64Qek8v4G1SxTH/ZPt6fkYvILP8AzBv5bUKtghukZUkAKs6WRdg
 O7bkFTG7eFOY5NUR3QyVowhfx5lNkj8WLScwfxm8iyaxJ5WA9NcU8R1UZfO2VJNt+V1vn0KvL
 1aRpGqIZRdrB3PXm9SzFne41cdEFxMDePXqnDvR1rb9GPniU6dLh/ZMAk4xzflpREPhKGgNMk
 k8c3aeT5pyaqC5jFxozP5PpJGhv2sLrXZ83c11o6c3VBbpLbdxuT2HsCl/SMAY7yrJCN+U4yj
 JGAU1v4g8Qs0HBm7/ddj6vN7ca8ihlcid8d9HZGbn77Wx1K6QvlGYwJJkmPbJCYrWfixMTfo0
 qEn9O1TUAtHDIj3i6YYTKE1kjbAgwsBMq25z2kDGTLVZHeU+SD1SU/6DExhfj7Dm+rPEu37Sk
 rpfwIpw+g2FSbmaTBf2r2rAN6QknMvYG8xD+nNrEP2ILhJBaxcrFKSR8hPjcQ18beFV6vWUM1
 DXo5DcpewZR0DPbMjKz8pv/bghckFPxz9Lg7UG5xO/m3BqOL+wiHTrNZjHxrcbTv8OrCWilyt
 pUWrsVFypWse2J3CzKgcYH8xXA8ms/Vsqs/v+WuHq/9kwW2vqcBfB9RHHYfuh2nEHlNOxwhgc
 bkdd/DBvilicBVId8IkPJFzAPszapordD38ipWLeQ3Jl8dXr1SOjpNDoE6dn9nTyojt48Cxkm
 xOLrt5KSfGwL8tD+FhfLEr0k15WidTrGvZhAUgj2Fwz7NRMc9LbqUGYkf0lXui2U0fI2Na2gW
 APakGhxdiw9RdQuphEfpFU5ovnNb/ReoR4UEu4lMgltRLhKY6mELRDTKJNlE3u6AZM2QulYoI
 OSDhhy0/zy/fS2++dZjLyCvDRs+N4gfwuRjEvuWCZkrbQiSpwnOvfgD4jbSDk6SEXZFQiqz2c
 gyJXcyVGMkTomJ98dTLr0iWd7bgjVoH5D2t+fEW6SHlPANGZNCIi52OquEkLfwFYMOO0DfZYW
 BdmCnDzBqk6lFb3DE+HMeozFHOs+/pL92i9HrMl+sgSsfNifaDgnOZM1OUJVRxmxd9eO/TeWh
 uBkiRZosSILvCVGuio3rI9Tpr0WDfiK9qKgYT1YBALcVBsz4LBUj3I5u8pBdl9hgiQgQVQoXl
 PqPMmTgsYGyl7JT/Zu7TxzS1ydBHaJmlp1pVpsTrhhYa0gniHnWku/fpwIWpP52PvTv447vdx
 3QIkRcfM/QqPBFpVEK0c31IpjAdnOVgTDF8XotnxLR4xe9GPDOmah+Lat8j7T3xQDWWTUT+7I
 /YabUlb45WZq3QUrIeBCQnmSUObziZ9GsKpIUYPBa08m/90iqJR/XX4DGzS+Ff+D6M+lNQZdw
 Gm2THzhkHh08Bxnez+ZyuUXbDug5Q4ZXtqV427xfsxU4YYjhcSOsGQNu36G6PWx4r8MWMOxH8
 qw8WOVmZKBnOAd4VlmZkbBwXQUjFrafNN7OEtMr/L+3Ec845dbVONp5+kTCRGKthGVOWjx5px
 wb5EO4LFQw8azFML6HNk8W5hkUbDnAO2AIgd4ItyQwJ/j76kmpkmPFl+2mrU0nQZe/CtoMWBF
 i2mZqrJMOfmJbYPHcfDGgJ9BDGQufDWcn6y1c03skb8t8ZiJ8CkmBKNfMDEJVhfA48jqjhOrN
 5cDH2m4S8hA3dUB39YmjQoaqM3p0ehIrr8J/udiy+e1cC5YPh8UgpRNm6mgxaxDVfL/YNPzij
 FZfT49JF6vQJzIPg54nZvPqbKTPE3JBp/3sBfsJdkVKlshsC6u6/V/PmBBUq7vgB/GZb9hmWM
 jHDdQ8ikg80iya/2AS9ttrl4LjW4rjha5ZmFp+KkfWYndER6PoM92SQ6sEB9McR9NjVBivjIC
 nmrsqWw3ZySK3BLYCxSG++Y4wKC6XQJ6U0NadMkw2bLPz1SZtH6KX0evzIAY/tDNKvyfj1MmM
 VpJYT0c44MoHGMhwFUw6sOhZLNMZmU28bL9J+1KEjrbmTrSAV9i3cBmOncdNlykiFSZKbIXLX
 9P9L+gtguVWnN1grSrFkxcssXfTmJZCDc6Q8JkX2jF+xEkNvMF/WqZo8Uh+KAtrzp2TiqlK30
 4isrBs649xOId1nEib6laZIBGG9bp9eBNN0DppEBrnGVY/gA55Rkk1Y5le9U4VYKVBpOQ1/xl
 CNHPekyO38OD1SbydJ9x9xyrZNzC+pEFqZSF5o08mvsQwEOvZdPN3tvrueojkFodyRtdxDc06
 LhFNTjRReG5E0ZxpI8lbkP2SWM/gXlPZ1cM0yneTqK9kd6WEM/2DvWnJfIWKfCQChJ9+KIbV5
 02BKAXVbIfiSqlsPbT4+1DdtaFIU/FVOHaQd/1Zs7dXQ1/A2ZxBIzRek26uK8Lw/hgyr3WOWb
 I94tit36GuuEpH9zxHiO1RvUxGUa7XahsJvD5GX/FhsgA6dlV59kmQukyCqD4CoB9LJXZdlQb
 1CulFV+LudaeZZxnh7lXlbG7Jc5dk06vh/cFzYp/765zlUkvs5lpaYefj47rBBCELNXrOKetx
 3R4CIecEyoSGx7m8x4M3w1ADtQRdKkNFW5bsbWtbjXxAp/8xE74EiIV0cg9po3L6VXfgIF9Qs
 X1xArGPHGgefYdznGooUk+7mPxy02Ejc1pSNFrScYCLkP3tNpe2FgbvlFXvWT121duYDx2RCl
 D0cvGbS0YNgBDB+heuveJoc1lyo2ySCEcTGdF9HoH/lwUu1mAwSygX/BlMWBYXHr5y2tPIe7e
 dbldWj8lP4K0Kt895AYqlmntPKnRfz2A2hk/sQNUsytFXiWRghhzmG0Cfe/W5aeoGsFIH52XT
 us9ewaLNLmeBSDqlxuq/59IujTYGpco6V0mtVmiObBNON2vcX5LwZUe8VBdHeot4GZ5zS1xuK
 7u+KJXKXs1uzfOjS5G5zU6FOw4xVfvThvus4nBglr+Xy4eoz8ylVoRZM1kHvbAo9hqrKgHR+6
 1h74Uu7teSaxdQ5ON4oGLN/s22bOcSnl1nNmgm6yZKf5HX98pUvKlBpgrL6oL74AF3UuvoDR7
 S7DJfqbdLG2CE+Vgu6ri1uXI39KI5liTJGn78B2UAMvG/a+uYC/0WkQwjju+PSKanlEFb7YSa
 VRtWQbbvgiJJWDvoG3+u/j99wT0K62LgrwJ3maS37sF6dpuQnsH1fVZQdDoq7L9ETe0MCVcys
 x9/9N8eMXVDib74whcrF8Abky2Xflo5Ds1kBnmyHlw27Qo4rAghvTXDLx4sF2L/6n6pHEhPeM
 zVGI3igrlWQ8U1Rvwdt/JrG2wuXZHmhBlEzOG/JTUgNtN0gj7BkAs3ZObI040cMENxfHyqZw1
 IdKeaenGzSPpRttPmly722A8camUZbNuaxqt5Wg9ACIKsQZh2cS3xTFzep/PGIUQ0iFvtd/Lj
 I4Yw1gV+bQWUmtLp4qAQl0NLxWenqRHzOqCTU9vLWJzkxoKmLVdS7r3+vaUMbN162CqvbKWTf
 YII8X1z34Dc8INRwhLdki+JZdvhwZaUac2vy+7odQ3JblRpM+8qCrlaScBy4b8+/O1HnKBbxm
 rZkVbnixT7kmDh0h1qCNplicxEqD8TcO+tv4Th6Ui9EK0Lfcn7MxFY7/x9o5MvdjMJZe25tIw
 1Eo9zkEoM0jrQ63umIrPzkd3+kmWdLEE9XdTaGiULltEXCotaqQoTF00d7Sukgjg8apQ64JYC
 5suuhzjZxx3Xiof3Wc34Ag050w/Fu5cNwIL6q3EDQOd1qu1BT1dJ0p+JL5uC/+MSCy/4919KC
 JRu70XIivSaFwyDjTjqQw9+/DN7sE4ELfp9WjAZq2Q1Jy5so9oelDCutcf+0Ho2CLMRVtRQvM
 8H89MeAR4WawR6uLM+PNnUbGLhXbHeGBPqQvjhW4vceAoRSuq1PRnl1Y8DomDMvALFQdbBmmK
 P7B5VMS5KcBNR7k+XBtdgAVReIx+i+7qogVNQm6LZHjpl4N5BM6p3N502DNcV7A2XnCZspp58
 rSnHbjtKQ5iUlj6ysCjAr+RmLVmaSEL4pq3wb/Z8pA8jM/xKtGZ+m8g4cX53PP91MIzOjlGUV
 fQvdCW+c9r20/yQj+NCo4pQF/bKoaniWd/+9xyEBngzWTjJ57kF7qh17lvILEmOgly4T+T5c1
 GizgDZe1kRoxbVd5wMPc7Xq2VZXjsDrKOjVVobapuXj5BJze1ggE0SxxZKG0uQ3gPecSOBxXh
 5rOIdmeDYW8GM0gj5Gs/LJ10flTN8LtOtCh+7ktCiCl+G40eEqYyU0VLQUAK10Gwn56dbfRzj
 OYIY7cc8GWhxT7DtzlPmcBvEC/Ptl+Qcg/2udYSLvpM9AGFrtnTbmCjmqw2BxJnCmkCIv52+k
 f/BuOC1KMLZd3Gr2GidnGzFl9urYu+TgsX+aOm+dXXUOIxdh9N7ojd0IK2N6xAjSPVWGlspOq
 wEVenH6+iHCE2FXVAbNUHmxuM8iDqnPztu8Yq5zDJnfur+mhuFIIThhqDnL12ZXx5yj0wMOSy
 WzAzfB6GooiZEwEvlVjQmxIL6fItT4Z+nYTzNYzzEMA690WLmQM8JzhM1eusdYGc2whubBSTn
 sa1wgzb4JoV9f5ROF2TwP7AZUV//xtm6gw4X8R8hm+kl9zQwkcRMIfBTvoAHKv8UVNiWEJwBF
 F+qKVX/axcPJsb/kzlHE8JaJAUYVAiGH7mqvssHJrgk9Sd5FNjw718rzUEIyVdKHZPv3YJFba
 viIUFnMb7rmDZdr6gc9Rt35HLZyTmggyTQnbjZbdUkIunVIZz1piE7cJna1d8rOsJj3oX8dHo
 HdoDzs6fFPnpGn8NPNs+X5Hf3U2Y1lO7RMsWSXFSts0KxNHMj+gNczMZ0g5pH8sAuQj4N4fu4
 Z+/oieJT0RReeFKlmQOUuuwh9u6KZhFLog2R85EP6VbjZL2G/pl+9g+FoBNFuzP4PZNzLpbs/
 t8bxoObPeyZQcT+k30UVf8agPuayA9tqZvDZv2UIfBJ29SR5491+1xbhF2GDslKFh7qeK3JJi
 pbno4Ko5tT16nQN1+JzeZjAkfHOZ1WfTG5H3ZpP1b1oNV7nGNmWHf4dK5UXAaoYHIbjeN7DBG
 AdGjOy8xlMFe3vaH6RNNNfcx++aqYUWhEyB1QAfE6NaQDXciuXBZoD33U4vyg6Rwqeouzx75n
 R60Kyi1XXI6gMbJ4etdxyq1f0IHRaQWKi/MRzEm1l2PAEHK7ixN/VgZADg3otT23xi/jktLeN
 VEOivX1boU6NhhKZ5J/47/1QPc54tHdCIFv85Y8Yi8tbyMx5QvIG0flsZQf9LBr93pM2UqmeB
 ssa2wna77HgGBOQrXltV0vw/6+OumSTyngCnDPzf2ThojHwZ1JmpujxSdGrEZGtdBHJinJN+p
 nnFoP2TAs7TzhcH/iwGImiQTwqDJMgoDiMigcKPhe3REj5QoJ+Km8qORxAfk0yRUf0aISCrkN
 m2pg255Q21kQ0pfTMsM6T2Jqhk3g68whyEnyXeCR2Sjzq2zD7PRoIpll5vSIpsYrLnl6UQwbb
 z74qvvGy48U7d6qsKjniDVixGzN7GNX2KgNoIBmWcpjTSUA/twYfmYJzGVmISPTBGnoSYRGeu
 RX3wOGNngR0Fp5bgEVfB/Gydpl/fF4JnW7o6sysw5vM9gKLmpaTr7pogj8hp6lArKaKHKCRyp
 8knzqoeNgrkFGtUd+FCVKPGlZ3f+du/So1KUANhHeWZl45G3UMy2V8PP8LmTkXeG1wdFCnqXh
 MJCxVFKHgMf5hYKF0ISl2MrdD7nMd83OXZhvrmMpu6BQj1lN2KSOPURMoqmA0iV72oJri1O8P
 Q9uOXwr6FBRx4QvMZQmchF2i76CsOi2Erxu1uWJ3Mzzv0uw50FEMMeU5MzFky776u+L1nYB4+
 awxyOT0gQQczxy8g7YLIv35tKZoUXsjjua6GdS3/VFW2Q+/P5sw7zSTugXf07WxBD01TMKu6h
 6HWWtfRndbg4DyMwNjiAinHfNq++PLTmSw5WGGgnK1+rjIzdTXXBXP9+oz4FDo8PWUdeDPPXa
 Af6zU72g3nAs9A0tGIz+H+sfu2veL/qgJLHtnDZCW
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

VOP2 converts RGB to YCbCr using the matrix selected by the CRTC
state's color_space, but the HDMI encoder never sets it, so VOP2
always converts with BT.709. Once the colorspace property can
signal BT.2020 colorimetry to the sink, a YCbCr output would be
encoded with BT.709 and decoded with BT.2020.

Derive color_space from the connector colorspace before the early
return, so that a colorspace change alone is applied.

Signed-off-by: Jan Clau=C3=9Fen <jan.claussen10@web.de>
=2D--
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/=
drm/rockchip/dw_hdmi_qp-rockchip.c
index 9c4cf68d79d5..10c5b6d6406e 100644
=2D-- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -17,6 +17,7 @@
 #include <linux/phy/phy.h>
 #include <linux/phy/phy-hdmi.h>
 #include <linux/regmap.h>
+#include <linux/videodev2.h>
 #include <linux/workqueue.h>
=20
 #include <drm/bridge/dw_hdmi_qp.h>
@@ -187,6 +188,19 @@ static int dw_hdmi_qp_rockchip_get_vop_format(struct =
drm_encoder *encoder,
 	return bstate->output_bus_cfg.format;
 }
=20
+static u32
+dw_hdmi_qp_rockchip_color_space(const struct drm_connector_state *conn_st=
ate)
+{
+	switch (conn_state->colorspace) {
+	case DRM_MODE_COLORIMETRY_BT2020_RGB:
+	case DRM_MODE_COLORIMETRY_BT2020_YCC:
+	case DRM_MODE_COLORIMETRY_BT2020_CYCC:
+		return V4L2_COLORSPACE_BT2020;
+	default:
+		return V4L2_COLORSPACE_DEFAULT;
+	}
+}
+
 static int
 dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_encoder *encoder,
 					 struct drm_crtc_state *crtc_state,
@@ -202,6 +216,8 @@ dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_en=
coder *encoder,
 	if (ingest_fmt < 0)
 		return -EINVAL;
=20
+	s->color_space =3D dw_hdmi_qp_rockchip_color_space(conn_state);
+
 	if (hdmi->tmds_char_rate =3D=3D conn_state->hdmi.tmds_char_rate &&
 	    s->output_bpc =3D=3D conn_state->hdmi.output_bpc &&
 	    s->bus_format =3D=3D ingest_fmt)
=2D-=20
2.56.0


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732B9606A31E
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 11:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=biqn7KUl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBB1A10E14C;
	Sat, 31 Oct 2026 11:12:18 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6DFD10E14C
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 11:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1793445130; x=1794049930; i=markus.elfring@web.de;
 bh=E3TMZTGteJrOuCTMCtS7kFaeGodpFcGQDnNZAnVwAG4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=biqn7KUln9PXf0nDctEocAFm9y2++cmtRPzyJxpMJ3HCDx51rdVn1CgNYYjXA6Oh
 eURX5wmSsZJ2j0HOiLLN/BHYbBfsbt5B+IpHcKqWqCRHr5wIUQFADKQCFwn/xmVsS
 RYN8QbGo4rFnPuetz6R7TtD1iW3sRiCHbBkOL89/g9d/9gdG/Ah5xvfiCrWu1l+Dh
 LFQ7dawSS3gwyplNWFXeiyRYHxsnWlXw3ptPlLz5PfPrx0ruZmc7GqOYrl8kJLqlb
 YkJiShlYjGZyXwPU7iSGi3D91doSMiIuC4x/YrzacPgEGiZIBV6WbR2zJ4/VH8ZID
 3rWjh5W7Xb/KnMw8JQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Melf5-1wmOg30Dor-00pZAr; Sat, 31
 Oct 2026 12:12:10 +0100
Message-ID: <2fbbd0fc-3f5a-4bee-9a46-1c313a96fa6d@web.de>
Date: Sat, 31 Oct 2026 12:12:07 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Matthias_G=C3=B6rgens?= <matthias.goergens@gmail.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Helge Deller <deller@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20261031003424.1796478-1-matthias.goergens@gmail.com>
Subject: Re: [PATCH] fbdev: pxafb: initialize IRQ completions before
 requesting IRQ
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261031003424.1796478-1-matthias.goergens@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cno3E0OAhF80A1wicTJfyqf4Ur7vHjAiqNl54qMF/36G4Oe0vhM
 orl/IvOQlm6mGzUG+5PspebV+TyonysHANhAXSyQpeV0ajHzfikiWrASKfojXwSprBdcOC6
 wL/AzMYr9aiSjAG7EtPQqaF39m4sygA6TjyudmWHiQtPFm+zJaaI4BxOoTXj0q5xCBYTHCE
 tQpsz4NfeckUnps4p7wlw==
UI-OutboundReport: notjunk:1;M01:P0:kSEzALIdoPU=;zdPriOLF0ydpkblI3O1dHuYJVAp
 dBQkUok2E10/fZ5yJEXiBVnW1e8jjR+jjnXuhNT4aPa6odVlFhuoZ1aTRROjw58eCQzdcVlgM
 yXhGCl1Qqse1FmXT8eBZwYYRKX+X97HhFGn+G1t6TnoMmkeEJRL58mjItaXBQuurNnWDXyTUV
 PvbLo5uv0FVd8vS5ZJL2eNzqZklPbkZQXtXp51SSEjj6hgh5nrkENIZPMgNn9KwT+IPMjPi7c
 GsZK46OQbYFNBiOsxCqneFG91B+vczR+MWIoIOKpLANWXNML7ds8E9pjDwHeR3pCKunIUAs4j
 vhciQElMQIsY/PKyV1cd/AVV7SbceEvN95123l/MbTy4AHKXNqjUWYi+kj1J7nkayp1pcKp5X
 D4z+JXLgpgXRImj7lRrVcTcB2wrwBt+DMoXcXv+gQ2V7PZdBMrwhn3RCbjLr3vlA1pFbMNGFR
 cM+3VL2XUH4wJBxZAtNKS04UoYiO6QXhTtL3Wv3QS+h/vFTqUEpDkX7GghphJkbe0BhzqI9Pq
 +IPRdoboVUgo1vpl4C7TULE3EdasuTwTVgLIx/IHsoeJ80uK1y8Ju6UbbTesKLtG90p442NTo
 j6ogmkciKJV+mKtY+D5K7qfmhSj7U8GOol+7kU5GpF0irE3vu8jrXqYoVm3AR9xaCLZRsU2HC
 KEzi8tQqJ6fvEcEtJtRp03qZ1ODuS+6CJ2C+NuRao4WYFluPIw6xWQncEv+bHoQw81a2zAHLb
 UYA9jVmel+OqiJ6REtyrEl6U7q80NVpzOYgEjJtZJKNRcmxA7ontXe0x4gpRJwhCXSzdG9mD3
 VARHAMtS5xKSuKZY1Cx/UMYh1QtT0KHY/DFtHQY/fIJo9HDmgEGhFWo6ahbVNXl0ncDzaXXtZ
 2Y52Rp6GGYu6Vgs4ZE9rmPWnUQRBa8hzBgbKwzkUVvPKpuSSgqzGkKASdR0YYvOKByPe4g+YF
 rLlHIv2IZT3Xx7v2LVO73Pq9bRw6OJn9u6ibVjcNWv7hWvxGsHFc3Z5Iq9stl1HYfbYicyz7n
 36u3ZpnWFY8YHSVxpzU1JJeDhyfmI7Rhs4QmDcYHzH1+E4Ow8AFnJIy8ArujojJAn2VTQ656R
 GHVn+s0r9JygloTz1I/BFp3Mk4unJKA3gaDSmLN6Nk9CCPhSX/acgdKepT87jsDQQkhUMt305
 qQuo7A5VBXncUIbARReL3VLrfGohylEql0euHEkFOaSGrpcGFEzpetD4S8xMpDUkpPBoTIh4c
 VGcsGG8hN5C3fg/bOk1oqkiCWkAGuynsDH7xQfe+VpGwU14YsT2CaYuTsqf0jXK+E/h8vQo/h
 PJgLspkLYecTFyHs/QRLv7TAv0a8mrfGQcoLot8XqxgoSZq23bPFpL2w+E9t42Qdf9emOs6vy
 eRInXRtHyVK5QdafUafLYpJ+Nj+G1PM/26nwBihTV2/rvzTj+7qhCOntD5mSn6HyMN05zBYF6
 EkIyplJc18P6Re9u1e3ukkJOmVlunCGBbMrUjIBFKrFCi6WJ7IWmB8FUxWbZo6Y3Q4Hcwm/HM
 7YfGht4R16mg/2r4PVqYRz15JxscD7i/TrdbTpkZ6v8hACtIKegRYWi4jJq6dOWDk1I0z98pi
 SceXWib/kPTXPRitaPZhDrCVW94PY+TsVl09BPbCk19KTTjTNnEmDbD1/1gTbu/LujoWgSyod
 KiSu14tRryWYFFLlcaAQ7SMpba6RcrGCjtV72kP8P/JL0S8X9m446Ch1VVamdogO/9/6nu3Nx
 6QqqrxyCAOf/13bEL/egvBQjm/Slr9X5kVd4XAwVSC0Bvwp7LO4Yi2h/jMVGdij7byougcUE2
 EqaGAYDm7xAmnJiLBR6UE25KiEL4rBe5E/iR4wvarm0Xv768lATTNoeZKdQq4zRKw825wc4e+
 4+4+fU0B8Imil5sSHRNNfymiN0RcXuonQt7LZrTeAByHRus+xsJ6CMmAemsCJo2osciJjBouE
 KSkBQz4NCLUdRYQLw0hwGRDCJMcUdsKc+mwpdSCwwLt2rbArwq7rFSz6oIyHamcvF/rizzGgW
 eQAoxY74LMYfHickkYCAmZOLW4fkQO4nj8WCDHhB6dfnoDJ7uUyQoIbLx9vvf76MR8pMW5X5a
 1cJ3iaendw7NrMJFhPDSeSE55ga73DqMtxrwUhdqAQzmnRVAoq9v3ha6VhJJKi/m8MyPicJWk
 aWLVBWE6/1NsiN+X09xXIRkruemucLiuNOBPZDlPY66STTFc0hUSt8Fb7vbWPMUAo1/aZL4P+
 sYNBT9T8ouKtS3/n3V9LcCbeSdt9nGCt9PhaSLO1slwlCsMYW7U8ZCxyqe7c+9pYcR83pD3R+
 Q+SUNs/+HKcn/GeKlpwfBUXlgNRSo2Fd2u5eaIW3PptdkeNbs2ooR9FrLSSf94JMeWTaTaCLN
 2rNAenQWdvj11lpdMP/KQIA0g+Gj6iNkYL3Km0YMEbtD0ohxGuYbJQQ2q2uMs2ck57ZPAC0Hi
 pRgqk5awM5YFe1McIPuhWnASxMN8qS1WJ7n792bnbOxM1qNHFGEQntTpo8UxqjmUOmHFh+BmC
 VmVxIhoBtCFnMv18DnqnKnCt3rx6EMgsQKllBgc1jnqLcyc4moMEDuVCzH5tNV/9T/3cRuER2
 qen4rl8zXFzmJxJZ9PWVMKeFvdU7Y1r4yFayI3JzoMj6PoS2pilLhVtmTkLdQJF5LxgmMtvMg
 rmPYP4ZqwqLEzBdVeEYELaWX1YDk6d+ZtIKKiINht/VqN1mwTqnXNfZPel/n9Qys4suBaY14Z
 DRew1DyuWmWLe1ieT37DY3w93RGSrRqzBrCKjcPLsmO6yKSQDKvMqe5XckrGvGQsGM8hz7HBD
 5WkmJDV77W/gQRL+1PwLvaQfQ6zxCbvkgfaePnb5Vmod/rwNy3PZwj/aK9sMjw2QiOSqcqFkv
 UnfW7QGrqIHao+rOQTTUx+cxgWL0WZwk9LlszAZ7c0oC3HohrRJ95VPQTyCB8mdAh+PxKCszN
 QxRv+LkyRb88X1IfkgpnOKPpT0EA3c3M1zn5GDAb/lppNhznsOqyytnDKnhdngXOAHzZc54m3
 EFTXGfjYY9Xx7B0MG3htd2/UZbuphSCzgSkoX7XF+A33ZpYNHfBry6hWBl2AFEqgBlQqcW05Y
 shdNP5aYRgdXF4nJVI3n48S/t8zQY8Byls20o4T+XExT5moPo1Ovk52Z5Gj4ZpNFy5R52+zJB
 hCk5ZLtkYeXgrq3Qd00XdiIsbEJ9i51T/gbRqP88c5duKg9mfeXqqY19EB1yBPdQ3oZFKv3pC
 ozUlsbZ/wkBHs1epPIsS+GqjxU7VQXyqgzWX+H0VvsKs6kzDtcladJo8MUT/xUgNjezraRY6p
 jO6P56xAqjlvkU74a2GsKIAFQz5YpMJYVhpWF+KNiMz6NOVA9y2JDvOGMpSr23JgGFS3eb+2N
 cy9Sn03nZ0kBW7pvIzZ33/2Amw49KL4zVTgF5S3xQJXMao++XeMjqOGhM3YTCKaeG46xnEnet
 sqsRggMVk4FhERZfPx04/bzMA4Rmjegj/3aR5P46PkNT2vAh01qc0SKEUr6w+6e6MnUeAZu4A
 0iDUEmiAvPmLp2scROW4Zw7t7INMwCEsPFpjYvkmWQ0TBc7X2yLwKVDbrYfjStqvs+utRp+X7
 Ty7XNxe1z9BG/GAcD0Rnmi7R5wmNe6aCXAaLVbsRhd99oEAVA3yGamsrTKjapKLxhqKG4d7OQ
 bVAkUYmv6QT226ca3IAfqi951Bqs7NvRYMM1B/RJO2p9DgtMladp7652zzqYPou7bqE/uGvO2
 62/Lm6Z/1+EcvjDypzetkH6gK2SxqjLxtdQ3Uo4BRtKQyURkb20MSzBRItcMgi0ob4qGkve9n
 jddsBu2O1S6oM/+j70dNULoxlbCRdNpHrpRnMmOY9akkhylPhvfR+jgBqc8W+6O/h/JLbAPjn
 MlLX30vqNIIKcI8FLpqOSfhg8IDKIaBaFss7ZxVN8aFjRHytX8MiYhYAPElg5ii0G5EIlSyRn
 /0qmxvpWlhmB37I71Yt5vHYpFYPM+kbUKuUFyLj9Q1FTONSJtf6omLmbd1YwH1hC8rPtcUk7q
 bzZtwBk4AWjogpJz8GRQJzyd+e7TdjvziP1fR18eLWgtJyCsWxnzEYRWRoWQGKxYIoTrLlkLc
 NqnmLXbIGEY9cxZMS30yVkjy7ynqM3Br7PETpmNE66CEmu646RchyaOmxyg1cr8y3xH6Ome0B
 H15+8cUw8Px4BqG6gfuqJmougLf5t/iFxTBTHsYJamHTmP+SC3v0pARFYBnLTwcaY+iUFi4KJ
 8PFJE0Dy3j8FZ1BFoTsXjRk18hDTcllbEaFmk3gaFxsfaq0y31EGFvSNXgv8lbAMLJWb89HgN
 BCAHDRJ4fITHzbw3n5oJsVb/CxNmwNNtLNbGejDpAKaQDvGh2IKfZSnK8HqzlzXodCievxuSi
 xulmVyOrUs4aBq3fUUHiILxK33CaaWl5iJN9NmFZkRy5LBwr3e1dncyCxAaUD1s9Vdc1Fn/HU
 +eOoMIdIF/q3dDnX96GkntfLryT84N2SlNo+6v58+QVBGygjTD2xO71usL7Vl0OaJNlvt3PDJ
 GlIRgI4s7+SJn0nwns0hHhGmWdJkO8LhxbjcOl90H+5rECyS5Bn7rDCPR3ksggmcp+WGwWQMd
 KLY4zVHYzew1v+GOrx666li5HYLhxeVzJONag+E2VpzlYjCOxchbfLzgVvsXf0E/qYlmMc0Ct
 hS2QKndsh4nJjocwVNPVRPVKnTB8SbIw6sswayiBYaWiZKGoXsoFSeEykH9emXF/H3/XZN+3R
 3qQB6DPvSbxxqeZ0R5bxAGhwTYWsajKWTp+afgmTmsOBYh+oHVxL6a58CkF5V8SfCfOzlYrPX
 X3MYIV6ePyqAFIjbjMviK/e9mQoPuec0uzi3yXIrNDVwCLpRok8zvXDst0eND7RZVk8zGGN8W
 1q7HBr+TpGarXyZwd5OWt6veZ/5oAC15x2u8W94nhrjjw/9uYR0KcqYgOgxXEgDPo1KQKCZou
 MYcdCtrEToESElgs53rXji33zcoAlafQ/oNU7j5P1qMMXn19u/NJyMGPuCsQUkNhbQKLks0/v
 IoxglU4n6ybLB5G+qLgpxYG6gkoB6t2jmWQA8tlVccbkjWzARaUdj6q9nhAlSW+QpKqDIPF/h
 our9LjYMQW9OKp0+3JfA6MJDpn3tr8CtbxbSWDhA/TXBmkufAM972Uh3yR63p1WKo0MlUQApw
 PCd8mznmR66qQyt4ZpfKU2Dyx37Lxo2Zis/pzAOjvfrSHBcGa79XaSwkuK9FwGtYOZKKoDhid
 uRNojr5X4KyMMZ/PPeL/0sou4awus3w6qLze8qWhj9FrqwikQ8MlWqy/vVy9fisp1L5YUd2DI
 iKR2aBuyzWZNPxq7A3VVMey3ckzBgtfiEGCEujC7Lyp/DYLDYFEyGUoWhW6Z9p8cbxQQzkNK1
 dpzVSFvsEIm9fNtPe/9TQLnnH8L1o961s7omHtAcENyfFVlJ8WuW1kBGq2j9XPMzfeI2/xaY4
 6TMu7wpE4hc7VHsP+my9qdBC53vZJLZIL1hC+QjlvxLg08MnPaQUvTGWyK5dKBOOuauB9jP3p
 840I0BKDyJcfro/06b6wXIYPgY8cRMIZOU++2kSpGznJU4/MmamOcRJrt6ZJm3T0qSsplry+o
 h437+Q1be7lr+VbaLiQoFYKTplqK/Ab2V3D+fFp2nDyR3cqmVtSdAKt+Mt6elkNpq5VRSUtD3
 Sy5vSLadbZj15wHMJOz1TC5NatXbl6zBxfq0SFivVbHc1BO0yHP581+aujT5D87/XoyDK7g8p
 qjn3aMfI8y6mepUuc60n2AL9IWTGR+xlfnsZgjA0QNHfE4LCSB4iQYqpNbnwRTgGGiJCbjMOY
 Zz5p83Yp2NR2vEgz6RR40kAmer+4ayYalvjAi8WYRyowmYO78YEL0eYSxI9oYmUQSG0+TBVPU
 qQ4bo9t2ltI9XXj5aMIZ2fzcit3pyAUkMi5xYnxF6Vq8uGzesxmhfhL3SGrffhyHWqL3+C9Ek
 vHye0Jim+4/G0efbOqOEwtRDpjl/pYk8zz15UZ4G2Dii0k6k1eKBRcqnhr09SZdKvmIXd7waL
 z+VjU/6bDesaGHCd0AV4xhP5zd+Rl5vNYHmZThmkHAD979C4/UAwtMAULB3AyMOD3F66Tjh1k
 uwKakI9izk8lOwY3ZqinHTokQgMUSDU/9ZraC9NqU2LtJABkA41dz8HQapTllwNyCIZtRBXPz
 E7XYW45bFEmLikh7w5vLyLwXjn8zbx5llv2SLigHpkQCNZ1YVc1scAkkFsZkujLmd9XQl88bs
 reH7IxLnV4lH2awZ6SFcPETDHwOzxd7b6KNpgnkHLr82kY2ApbBmwG0bhmIiP+lZ0YqkQOBJv
 N377/TbeXlP2RvhGrJmLtQaDKeMcgiy/WhzO/EvQPJxcueP2904uUnKjirUddAmSZs1zVtcO/
 p/FprlTaHRC9tb0GGfRCwJ2TV6jESKxQNf/bMuLkb2JwhLjmi+GgbkojVdGwXNOVOaPDP03zs
 yuswzzyGGmYcYWPR2H+O820br0kk6mxvy7tQUmZyIjMzmcbdfOIwp7HdCEg1XYs5ITI0fcNsl
 lifg40k67Y4A3OPL4ydLhISyveVCqeEOAy8VgGigl5MyHI948cZeKliDewNXjEBq2ebRmqVgJ
 YiOZ/iqVSu8JGLx+GTls4buNgl2cJgEDs6FcqM4zc9ggyfAoH5/F0uelJ5B6SKg==
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=E2=80=A6
> Normal smart-panel init/flush/timeout/work controls also pass. Main,
> no-smart and genuine-overlay ARM builds pass; strict checkpatch passes.
> ---
>  drivers/video/fbdev/pxafb.c | 26 +++++++++++++++++++++-----
=E2=80=A6

What did hinder to add any known tags accordingly?
* Fixes
* Cc
* Signed-off-by

Regards,
Markus

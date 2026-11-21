Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5EE606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.claussen10@web.de header.a=rsa-sha256 header.s=s29768273 header.b=C1oenQtt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 960F210E9AF;
	Sat, 21 Nov 2026 13:13:35 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 714A010E9AD
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 13:13:28 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795266807; mf=PGphbi5jbGF1c3NlbjEwQHdlYi5kZT4=;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=web.de;
 s=s29768273:rsa-sha256:leEm+DT1j2m9Ihk9bmLg3mCtS65g
 8s2d1p4DvanGR3zk6k8Ogm2sM/Y5Y45riyuZAE4YiIoucdIjYsPAwT3iB/mYu2hKO+9/ub+QMfc
 lARtiyhhwPlyw0uq1ujIRhE6Y8NGzL+2Pehk6+dJk31npnmhJclL3uE7Z5Dwt4mzeDAV9dtyvYK
 KeOkuzkgvcq+xX3k3ju4PCW5D5fJbUHMxx+kmQyKYe9YDPIrWGLst1CDR2GaQ0DxM3bTtfPaeqR
 /UYmpnn5OHuMSSGmDHYdl7SCiY4ZkJrbpjE0Ct33bTrlJG2e19i5z/zZlfeASeJpzwMQNcm2LDo
 H2crClOFSfhLYg==;
Message-Instance: m=1; h=sha256: OqVo105IXb/z5LCyaokSwC9Lt8MfmIciWUXv5n0s+WU=:
 4/WEPnu04Gn7ZgA5ACkk2uVcQ27DoTP6sW72qU8QHC0=, sha512:
 uWNTMyr3C2Ta3fbna8WlMkuI5mslPOaGibYTwLv3JUrAB0rInGrM+f7ReMhQOmLdoIUkaJaT71EccXHklBEJPw==:
 o7JR4WvKvfrEZfXJxVeRJNRLSVwXBS3YLuC/6ugEdEMztxh7K9jFdCNBOyee1DRNvW/x1UMkC0DnaPjJv2KhVg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1795266762; x=1795871562; i=jan.claussen10@web.de;
 bh=V/kc6bhg9QhVTGrbewSWZl3OlcV209fx9+SPKbpQtKo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=C1oenQttbvyT7uSEi7iYtnNWM7pwqmrx0K5DuxXyOfOW8sxRM19GslHVZpd8Wqlq
 6/CwpUyRrrUbaiFf7tNs1xPzL/3uqjSV2glW76o7LkhTBpyvuhhfihWBsttLy55n2
 rYTwNq4cO7rnaIjVIDAGgM+s8gTu78JQXwyd20YDQ3ZgMtjyp8aIQQH2bUv710sLS
 sNyIdKS8mAPmkOxpNMHj2cYiNzVhjenzTaoJ58Ytw0kOa8bDOBdXnDmBu3Q0P68wW
 q6Vpqc66Rufr6X2Olw8FZiEJA+D/O7DZPXj3RxORTMJSr2h2GxaoLy4t/w5UlHOPq
 p117TSESVcdbJG6X0g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N943B-1ya56s3kcZ-015Rqg; Sat, 21
 Nov 2026 14:12:42 +0100
From: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/8] drm/bridge: dw-hdmi-qp: Forward supported colorspaces
 from platform data
Date: Sat, 21 Nov 2026 14:10:59 +0100
Message-ID: <20261121131126.3358-6-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261121131126.3358-1-jan.claussen10@web.de>
References: <20261121131126.3358-1-jan.claussen10@web.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2VcwXHFkhcK6SLI2c92IqKprVucakZdWjlwl0ocMWOpXUT8XDu4
 54KOKJ1lo6pirs+/s6kPpWadJEwQCRQtDdVI5e2a8PJxJ8tgWMZCJ+xeUbOHSRPEtCEiTKc
 L6Lqr+C8q/StvRZBCjqiQI9cPgZsl7RcKjAufeUcgO6p3XBkP/9NdXYdewTRTh4ue/46hWE
 6BjL+L+VgYFp2PGSBHoNQ==
UI-OutboundReport: notjunk:1;M01:P0:eODoexI4G28=;BDQgb4UY2PQL0APOvxPWGCN9OaW
 UmCi+8mzC/zK2gZcdY77X2hj3bvmPTbxpcp/nsycVO4az19J8VEya1QH3bw6ZWXbb3+ABqMTK
 Z1Rlawi9+eTKZoH/Bcl9YhBtw1zKik8+pZZNUdY6BHoIc/e7ng0D6cVweQRqdaSJ5/paZxRKM
 rJvpmcpYIrr3spBkeIFklEzslpo/pNNYOv0I1yIg53J3q8ktqcXX7EW8ftOZ7/JVVseNHtdTZ
 tk59N5v8Lwberd8Bd3NB790H31SbuYrSba6CZEiBYuxCpg/DK+7WpxAiMoR60PARVRqEDghvV
 hZpqpE/AhokWfgHG4tsci1peXV3rQDUS87RUy0BIfBnpCY8m4NYklt34zx7nelO0SSSTkwFSZ
 F/FOvlrWC/VnFfSXJHbKNli9vrQbndF8aHjjev7AW7Vf0tTjNTghVYgfjjOsBZ7UqvM3/L4IR
 SGzVo5LFDHvgamc7n5o0R6xYcoo2Ja1k+aMC9EnckedcgGJwhSbhCMOMxzEStqI4bd9MTkvu6
 ngDFpTBU+e7IBgdjISeSDQzUB83I3RnFvspZENvYlSdc384854Nxkfu0kRu0OkeDtYN84UOpA
 xUacIWpSEpJ6Y2chwS3VGFudO8ZykRQSf+iHvGQ5xn28L9Hdgilmh4IzrzGyQh6EaqzCWRc8v
 wKIJc1HUsEb1rWZecCovvqO+NdA3VJ7fuY/1PEBXozKBJGuEZQoDopEydsWFAU7ibgKkCG+lN
 0/RBvcZM8L5VnWSlVUPT0z98KGEKq4jk9ASUyxUzdX+bcU/B6c05ukxublf+6Z3GerBpou9xx
 7OPfoduvC2D7itbp5KH4s2bYcB0GUhAd3p10nanuHgYknRwG5n+GuvubvWsizUBCZZRgGNpZF
 Q8Qw6Gk6/FrjLgA8LP48ae/FbwpGhwRlHmv4abeqwc+77HKBybOUOxWyEr8Z7SxcH1dakIdY9
 Aj3ereatMDoOO4ZyRmSBj5x+UfNSpisgds0/ae5HxnxPN8Ythkqv3bN6sWKUExAxAQnDJyyFx
 HYr5suLQ9jscKM2jmm0VwwIPcoNWUBK4r0Y7TdeR5+fzd9Jm36HwKB4p1YyjRDQCeVR0aofwq
 f2875wOT3YAuymG/D0nY2Zz1KzjO8BU6h/fBk/+pesv4MzHq/O8KjelPONe6JTkf3Jgfw+yra
 1fsehKnnokaxnk6+SL0TET/Wke4i+DKjWnbdEYgRckKnHe75qqmR82wpD4fOp8j7qs/nxcB28
 Cp8eoH21kkArLIfjKQ3g+JSLa1cQDtd1YOOsi8MWfNlO7YFc6jR4GITstxf3D5ll45xbkphId
 iR5JRyN3mzToNRUs2fuc/iKeS8mcB+Or4PSVDI6E4mElxz1EyCympB9YdsiIYYY5UdYOMevEj
 Jf7kj0IM5OzUk6XHESvNKMxj29v5tAQZZ+RnDKo6OE1IXDnIaELBC7QLOatQMzSm7JE6k9BDL
 AWMnQ2qn7LZQVLrD4Lmdi3zfFx2289W5JpncR/+YheW//nAEcWboWHRT8EWAbsO+Oofo4BmMx
 qvDqfZVRGREDzalH0nBbBDIcVPuaWdh6IykihVXscZX3YaBWKAyJKXDaOLxzutRrXIag9vurg
 gDOfBiWGUqRwCmtz3iH3TQaZbBJnhuw6ao5js2Dz/p/YjzqoOHwpdov4MAJv08nZay7HhgpMr
 WskQhD0f41I8YKjpaL1p7MGSTfyfIXeKiYxZbaw91bU0qLEzgBmoTeZIQdBfGtSrIlWYCKLre
 IWh1OfIpCVFhSX4DBAJo7s2twrJWaxn7AIqBQlwLwcMhUxDcGEGz14rNbBFLfMiY+EAd5WvM7
 eZWobZi0P9tc+LVa3fxRwQEk88JVopuQtkBHZZpGZn2YNIcT9suzj+nBdlRXJ2Dz3cIggKIqG
 rODjHU139JWoX1+gIRsBr1AxFWdh5WlTGptFITUO7S5MLKqVOwt6pukqgREtttfXZKXKaICaJ
 oy864rvhb55BrwkkQAmWef5qXqcHExVpuZQ9/nnzLG5tDCh7V42wTXo25GBtYhJ6hB5fMOEoh
 IznVVkSsfBVuEpINqgA/EcT8M3zszYxvacqAKgCBqNIX/WCVXFXQ4HjN2SHRQA5xulYStp0u2
 Reg49lDYon/6qNAAuZXu7hxoL4MMDyPETqJkV5d+jT6A+rN7QhHS1iAvlC9orOITTLYqAbAOh
 RGSpZjJRRx9/S6jmM0TY8bS0XZ52p/HHHJJ+ZG5sSo20BkgF48pyUp9X93DSojH7WHV0VFwT7
 E5ilB0T2nNYoIZEjy5K11v5MROEoi1sK0IKLfYoQbAvDGa95inCX41AbxxTHdbYe5nHO5k586
 FwKTNoiBxQqFdse7S+NqSi47hwUvYSo4jimScdOTb07YH42rymiuXmFk2fsJ9wEe58KPVNFnX
 64lXjCSAu1Bl8ENgM1N5cYKCESbnQKaDEhzUgfV0Ar3TItgFByKPzxmyTZt6p4FWrYX57iMX+
 Gz0/+SQcJM7G05HgI73V4FcWWFkKLmJUFDI33K/02+bABR8CnAfqFdgngklxpEORHvIbiURjC
 olJ1/mtjpnxbvzGC+RK5osfz0M9AAeHWZaDGuKXSR29g+MlVqog14sbY28UtGVJ4u9430HbnS
 VSGZ0Rtk2MYkKAf9UdyGW3cZkdyeZ7rUpj5iaDiESb6DJtwkMTFrrm55ikhwTLFEWEPt7oJp7
 Nkh3xoSQbAg/RNqjydOLLRhurjl7sxS/3Ka54BPNWY+Y3NRSp8SH6EB9Qsu4GIiMiAK5Tk4WB
 xNWJNp6Y2pEOfSoFaLupAojs5LGblePhewrF4MfDgBARIDt10TVuRhq3Nle6cD/ahfJHGhtGt
 c1oja3zzwdeMoAHxSKcaqEhJc9PzX+xYse81OT4f/tlwHT6H7rVfOtm9Yxpf3lNOT/0XzrJqY
 Pvr50g89QUnOEyFLf4HiHifgScmy5Sq03i0UMbPZCDjJYeKSPS/OTV/JShP+YfxcSOxDOrATx
 omKmRsodGx/Wwg8CY75bes2KUvInVUjvwaLVfoT2fryHYJHgmlRTdcIZyTsE+9/hwK7pmmV6d
 6HF5WL4E1UZdiuyqqTj1q8F3J+dF/UINTsU3deZu/ajOxg2RLdwzu11e6Jb2zCf0qfpSP31en
 LXgqjF/w/vc2wGHdnHUQbq8W6mGnAEGBLyUKHp4DZ5pjpDiX6NYSJweyLwBWDYyEMy/0eVAZo
 EYaAy8q5rO/jTb7XGvxq0my4gxpNv/uFkxX65DlXIwPNaXZhsB0tpVJU3X2GO00Gs/U9RKhGf
 TY/kU5H58hJs7aF12WvGWNJPdkTnCfE32I3bfu33D2UmS3HruOutD1B46C+hLU70egko5B5uG
 OR+F8o5MBe92zbSNr7KRR3VUCC4cl21oA+JMO5RfWraARj3AZxWcaMjxh6XS8Cmjh65RVayCj
 6/3VcDswbAhvPlRRQ9bAq/4sf13jnMTHg7lV/Z+gYf5VjsbPqGcKow5bZOd1QfJdXsg3MF2Me
 vWrY0LD+OKqtxsR0jLUwOAPtP4POgv2Sw3icrR/9IO6R1W/Jo/eTHOuLbnXvADj7BOmDe0ZHn
 7x2NGyeXnT58e0CqAMg9dZNTHGe1qdkVs9OtZ9hHiVcSjpCPzomg7f0Tbs7vtGQxUIwawGwh4
 Kcs9hRR6DTemHJSI0M6vJ6vu5+yJC9yEYhkR8pCJd31IOY7aA9gbABuI9QeyMeh6yI/q4SRu5
 4MSDS+L/9wY8ob1nZjH3LgIoKKgbJ9YAElsuJHSOgtq7Hxgm/K1ZhDEn89Cc9a9OKuljbhiVl
 bWMxJ1kTVurncBB0j2Ru+u0LpbTfsf9f15LCu8gNm13zKkC1RsJ3FSbdQT2xCz+xFjgTftPnf
 we8FfsTD/NjaqIOgtJpvK31Dkar34Ns0OuA/6PHhbFkdl2hq6vpiDlxOxJCjlNsxWoSY8ILS2
 D8wmOHaKTS7Pvyfu4ca0qokEfGal7t4zEIJaWEMxdUmDXLeudlRe7xDujsnUa3Nfo3+7a5474
 3np+W+mdR8A4dPheXVoovGOg+l86GAVTlAB+yTUcXIjLhdwVnhevJlE3MZPRtl8dkS6Zjv/VA
 ViDdd19HG+uCq4U1n8cSkRmz7QCg7+IPDFGzTIh4/Pf1mHcoXLmXBrNhu07i8M6xeu90e9JVm
 DZzEI4pJv1J3OYOeonmnI6LVzbyO4oTA83KA28l/DXFGpUbHYH/DMN7LII7Yc8z8X5pVZU+gn
 BoVZOYAheYQ1h8lCMcMjQuRrBMFIq7vnJsI+da7MUVzyU5nSQSpvARZK7fHi86zpEOsKG9eUv
 iULAZXISAhxc1pZAwc11T3WaZIWnMSXX0kNi0DoRnlDhyw+t4cmNBr2apBAgKqCh/yRBfD6QZ
 nRee4qF5VVu7lxVurLAtYmqEoHyAVgHSrSXFkLGurHlyV+9Mv97hWM5ieJJuIxFQ7mEBPCj1y
 vOGdvIhpGRVAgmcysNctQKFbjTtA1qDtJaMQIM8MKhq9Dc6vAeXwciXICD4Dww13/47YglzgS
 wWS51zqxFNwwYqck2I99fvO0IeKePHawKmzg1kiL4SNwMV2FZRlGE1ToErR1bSjfhE9iIbD9H
 B7TqUDSFXlUIrYGW9yS8wYb9tq3SYHfWXrys2jvYp8tKTcM18dsQLNrFJK9mWDJOG4lRMstSx
 JSHR55SOVXW4WAZViHOCB1O2pWI+dXx1QtEY44WMhGBf/P//tj9EHmyv5jm9ZEmNsl+YyUPcu
 qxbUKIPuQGu8SWK0pIhFSLbvaWMGF5J6LVKyg4MHKPw0xnyxbji2B+nieNqM/KT5ZFKXD9zOZ
 JS2lejmVRJFGDNLg9KdW31pIU+hBuTdy6vrulsldP4vFXkUgdjJ/wKniFCVfFDcmutW0N1Itg
 BdGGpgEhJxTWvdcionnKK0SC3BDvITnb+d3jrpCOXCPD8jML8P89KfydA1WbguyUg6qGqRt7z
 yCVGmh14VPMiGklX3bfS7q2XQNAjuuqFshQRkXZ9j0dhks7y1YGBvh6cNMhz5k34G676WgOGr
 ZfN37q2M1Dlav1yoKoZH3Dyl6uLxeNKysXR0l4tUpOMQz6PRScM+a8GfagjvSk1nn6GHw6jYT
 FfZ5CcFHhGPQM5tpNGB97qnzfcM1zD6Ox0La6Ez1mmIyzUP2Yi1rc4rCwG6ESJfDNylJdUNOv
 3VQ9k+q3P8z8kMWj34GOGbxTWTvrEQK87XZQtN7nj9lXTgMx3awFdotfzHOJ5L8D0Uk9ixZOy
 j2PYphYwYeYTw6YroY7UvuyuzTGcWdNt62mOgCLMALm5nZPWT+MShGclIz6nqZjR5KZinbC+f
 +4xj0tstM8qZmDTlqvNvIC+AjoVtIY5WBx2triBlQ1Y3HiL7qcaNQlkrebBlw6OmjhAWHfUJi
 ugwCwpnbNgSpRWct6EcRqYwneZ7vGKFK7d1sWJd8hB7+NBzshwNFZeQvUl92FiOYCcAdKBNdY
 ieicWFy3pBwBYPKSlFpxiuLLUnMNKmXbeq3aRPTuEquqixHB6KPwMWfAXebtNkJGcrmjpZhXQ
 TrRDF5VTAdwjtBSrlqrH63ynefgJ6w9c3z2S/T8eJbIaD1TGuMjtNhlgBeP2TruFC0m+/QQbL
 PF8B5h2tx8Vjhk7TXKZI+uqDv6aj4zPrXNDFGqil4NL0WevZm6+OAP0VdUvsu9dMozp/ysdIT
 3SEjvkkzzesO5AV6WwxXRmvzBaDGLHUKmQeP0jD3nBbZ4ibWD/9Sl+gjZxC87hl6I1Ij+Lj0p
 VAWa+1iIS5sPcImPknORtaDRDA7vPJ6kU7fYiNToWHue+dSsII498+/Cq3w/UrpE+v1DeWqfz
 wnfbFXM5dnR7wcM3Y6zVgDqhhdZ4ueu1ObKVZhMXfTM9lXE8p3pNW2Qe3vxrfNBjvcwhqqnuB
 lqL1ny5g7lwpMT+PkKwyebraR/WKQskbcsuGJ7XjGCS8TMS4gpPwOFjYtUeXo4zyiaFX8StmA
 Y/eoGzyvyp8pmAgfCdOe7cDXYOjJS1JuU6P5O6VhiST5piYxo826YMNhzZQ3fUETzJ1/TaqTF
 WW+Hi+5ClxfuHy9MypnuuY009yspKfR5DcbtqAhRceucgBoCqIWwuRwtrSlHWh9SH7uaxD77u
 E+ai2cMyJ8czPPYdVE2k8FfNpV2zoyF1nAoyKf4SCcUi2nNYASb7avsir9RFaBifPU3xCTEmO
 QWCHWP3dvDwETb7hQwO4MQgT0rFVIMwFsh61+7dDJqKP5V+q9Dr3U9GORRblDD3r867/Y7bkM
 jZXhEZA0luKTwybzHcqoAFMXLnFuGcAs2NqzaJux4nDxDJinHQKz764blVMtqTmIaGJTCCngf
 vb2acTIBTOHBWYLO+EXvPI+8JVpoMNfozEOHbFg2vIQX7n+pqyH0DxIcIZNEgP0e1ftOWjVBH
 +Kl0ivs7HrpuXEYLF2NM7xjsCt/JvBwBierigV5PmMjyABNpdEZ3BfhzYYKDI7y30gp2wE5jg
 7LiCKqVSqImflw6DjnvPdYMrHeNM1ojDMfVfOsUI2NQftqdGJJaXZ/ukchNaOsrVZrT1Bopkb
 ZNw5tayQjvlVbFB4xT3dPAFHMfG7crYOfN2N0EIv55RPG9odrKOTGrJjLmcKS16aFM2e23sze
 x6m0Q7CkuiGeWZnhacVOsDtnssrwFvUHjig3AAjpg67GfGgpGTvixhOWwmQ4og4UxAz/ScZMc
 IfXOZkBHv11cgzt3mMEWmlrougT8PeYB3TgRpVKkkgLmzc5S29mY/fubk6I1VajbPoc8JnaPe
 CxuSWH2ZW16bsdBvHOFZSCWOSJF3yfG41oY45oY8N6nP78fZzWA7LFLlKmJ1ZaJBhwtdakDZE
 gKgc9DC9BXMzEiEmam3Kf8JF263YKOD9cUsmDBkjnvpa7ppN92Ozj5UdGWN45VyWm0+flBZZN
 OeIkKVXRnnB+dWQxfsacMAN1Iv6poJ0L1tTjh8WCPvaCMCqQaprmA9HhYVQTIEBYTlJdWkKSF
 vk2nT80sjI0F1N3bRAR6v20Pl7HmopAwaT3vwck5A6kwo4ghD4c27xtAiXRNUHHKxhiIrHPbk
 0xyaxo+mp4CCU+VkY3iQYvIODyAoW3OYygmXcac=
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Let platform glue drivers declare the supported colorspaces, the same
way they already declare supported output formats and max bpc.

Signed-off-by: Jan Clau=C3=9Fen <jan.claussen10@web.de>
=2D--
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 3 +++
 include/drm/bridge/dw_hdmi_qp.h              | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/dr=
m/bridge/synopsys/dw-hdmi-qp.c
index b268c9376087..81180e9e8d94 100644
=2D-- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -1170,6 +1170,9 @@ struct dw_hdmi_qp *dw_hdmi_qp_bind(struct platform_d=
evice *pdev,
 	if (plat_data->supported_formats)
 		hdmi->bridge.supported_formats =3D plat_data->supported_formats;
=20
+	if (plat_data->supported_colorspaces)
+		hdmi->bridge.supported_colorspaces =3D plat_data->supported_colorspaces=
;
+
 	if (plat_data->max_bpc)
 		hdmi->bridge.max_bpc =3D plat_data->max_bpc;
=20
diff --git a/include/drm/bridge/dw_hdmi_qp.h b/include/drm/bridge/dw_hdmi_=
qp.h
index ad33f9cafdeb..c336bd40c9cb 100644
=2D-- a/include/drm/bridge/dw_hdmi_qp.h
+++ b/include/drm/bridge/dw_hdmi_qp.h
@@ -28,6 +28,8 @@ struct dw_hdmi_qp_plat_data {
 	unsigned long ref_clk_rate;
 	/* Supported output formats: bitmask of @drm_output_color_format */
 	unsigned int supported_formats;
+	/* Supported colorspaces: bitmask of &enum drm_colorspace */
+	unsigned int supported_colorspaces;
 	/* Maximum bits per color channel: 8, 10 or 12 */
 	unsigned int max_bpc;
 };
=2D-=20
2.56.0


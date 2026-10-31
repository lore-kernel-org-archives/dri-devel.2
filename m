Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE7B606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.net header.i=m.kesenheimer@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=Qq4D0YJl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0205E10EA06;
	Sun,  1 Nov 2026 12:00:45 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1516C10E1EC
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 20:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
 s=s31663417; t=1793479291; x=1794084091; i=m.kesenheimer@gmx.net;
 bh=HasLvy+gdiTuyICZI9aVdOm5ZJsCl31tzmSfQY8LVQU=;
 h=X-UI-Sender-Class:Content-Type:Mime-Version:Subject:From:
 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
 References:To:cc:content-transfer-encoding:content-type:date:from:
 message-id:mime-version:reply-to:subject:to;
 b=Qq4D0YJlKjyUUIQw5cvdiYBPw5grKwM531j2yPW7Km05qrImERdY1rs5fmC6R3I+
 I2Ti95lggSvmbH6WOZtHdvQWlEehq9KB9on8USdmZ4fqDDbdYj6EdRrAnZfhO66xt
 tIIcUnda/yE2eDGoSmC9IllKv0vVtY0YhNQ01aCxXiX5M6yBEjoksZ3ENJs3DEJ3T
 vA4Bnbcx5gHA/gSoR/lSmOEeaFxrdTEmtQnIf3b+SsjPTr0dgavf2K4uIoYyiNkeI
 tkX1E0OsO2fXjjpshjt+axau32h90YsYitidQeIA5+gE/ZfjPf3mT8GreAGJG9z/5
 tbfkE1HbLW3hGZ05UA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKZ3-1x6QMP3uIh-00VEEi; Sat, 31
 Oct 2026 21:41:31 +0100
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: [PATCH v2] drm/amdgpu: prefer exact bus match in VFCT VBIOS lookup
From: Matthias Kesenheimer <m.kesenheimer@gmx.net>
In-Reply-To: <sashiko-outbox-191902@kernel.org>
Date: Sat, 31 Oct 2026 21:41:19 +0100
Cc: alex.deucher@amd.com,
 christian.koenig@amd.com,
 airlied@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <2630FE08-2F46-4D29-AF3C-DD9EF2DE581E@gmx.net>
References: <6C5E74D6-8F98-48BC-9173-7E85D243B3D3@gmx.net>
 <sashiko-outbox-191902@kernel.org>
To: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3864.700.51.1.1)
X-Provags-ID: V03:K1:hxCN9A6fpClPphzDQoeNVgmOh57RXfPGz+FMCQKZdk70d0bigoo
 orS3SdnrrBHpyX9v9f1FPH9eWXks21WvMz4w4uUvYYLQuZeU0/Z/lGTci8VAL68I9jz7vAe
 xY503nXzz9txeqQ76CD0029y44Sbi5geYRIkVLS9ETBOrxFSbGCd8wEa+wrgvRmDxwhacDW
 G2o0cWEzQf5prqb6HVogw==
UI-OutboundReport: notjunk:1;M01:P0:1vqn+bi0UOM=;VzAgmopplOc+p+jP+9otQ8zzsNY
 bG4CLcaQNxCtr0P+RczaOvATEc5i1fDx1OBd7jTxqJQcx/trYQBPtN74JISejHYh417aLcryM
 6gR4LEasbLwq6EAFz8XD9tjqoMgFE3wMo5ZG7+3cKom/UOjNj48yaVuC0vI3Qc1YAd7+N2xMU
 yOlvUwGU0AeR6qYngbEUvvJ0p1y2MTY6lIFyJ5EvHRKi7a+KR9WBpQntCh2abv+46O2zRVQ8p
 6VFgq8uvLVRlo492+DPkJ5Wg119KQuRMSIf05K2Q2XoRW1AVzrYorY3ZDdQDVxB+/T8SXqZ1N
 Fcdxl/QONgkzicqLFxmNuawdbOFGgnhODcMj1oF+komqlwcq0KBIThDDGVa5jcRpAsh1J0aCh
 Lh0JoiHsNgREHmBPzFuWey2yh00KlopLoHe0jyGhgdYWNh/r6gRDKWGgGGtf/go23wjyD6U3S
 EhjcjtC61cUh5jZKVz5gAMRzHrc6JF1OTG0nGFoLw4uavJXl2XaBJ+iSeL7+6Ap1zpw4tKu8Q
 EruCBNAFRfcRgLOPzHie7D6aWaBEvBpg39Q9hyDblnAsxh03GKej8lyVBhCprMgglvl/zG6PK
 IJjgnYu8kNvw/QQTF7kuLOmhGVhkZ2rS7aiNCVuxepKnAxQzep8yNKrES1aFY3j6oR5oBUxN9
 6yXGpqtRfilh0Kva6QnNvy6KqszezdpSGaRtPyTCDE8vh+JQcWDXn/Q0GPrAJRH6bQUxFHYBZ
 jGxnKIjsgxg3egdIpMJHhX+HFbGl76eTHHQdLxu1il5XmnuXRChRD/gXTeW8Ow7GWgrfZthpg
 9YFxderC582C8uPGcgzaOzaAZPG2v0nOMIWb8pdPIPc5Uj6RWr6NzIDuXkMloLURlVNmGJXEx
 3TKuYhmXsb2tbp/poPCZ4YrMnFicL8NYJcctO9SCIx4o2+aPYj/sUeJdKW88km+al7LfetVsS
 1yN4AkD6TJiiku1W/6eNfL6RHFJ4iI+UQWB/Mzs/8mVrnuyYeivaGn17rsms2CsWxMcV947n2
 yfUblCWy14YAWcj9Qoviii+K9RHe+pqU4GpgpXm9ZYUvS+2O3Hxy9qLKdXtxU2/c+RerBrzsc
 SCwReV5C5Ma9u1p1Hwa+9894nQfgfrpeN6NmDoru8IFCc+x4NYD6t2XlPIXs5cYob/QWBw+WX
 hmJz+pG00YH2Tx/mfCaacxyhxH3WeAjzK8fPzoSBAYdxBM2RvPHTDm6yeOYxTTIvC9qpXMPt1
 6fmZ08YQHzPgFvMYCksRBqWcnczRFfFtkF1YsTK/xFRvbZjOoxvyzpwCfgYWlmhhIaPV/rJdj
 LmpD9F6WjhLc9rA8OoqVVWFDMHKuTnUI/SJiERpRlwFfeLqiKN11e/MmWK3V/8Rwa2dFF1MS0
 Vk8g3DIdcbN6hT9T/ClPiBVi7m4ZiovInMnYjPuQXpQFvA8KfaQNAHOdVQ8vaoLB4wjnAjjA+
 CmtNSghNYKyBlh0NUKhYXsfOptTx6U78Uo5aMNT5FugNIayRkQlewC9Y+RRUUjzoQguKbHIk9
 aVxofiGuEOi9qVU/BznivC57dx1ffQeMhUJ3e3oqgECkgROlw2peOnpJ3t53uWaPkFvOShqsg
 ImASq3nv3caRogKtJ6LSpzZhaMq120Q+NF5a4+4fQUileVOHTRz5S9Gb1pHSm0HxK5l6JuEhA
 0H7/BqCeJBR2XPGZHixHcdzFZPRfhlY6WtgtjRER5ZtZisW1uQjf/Ddbe4bkuAHEWI3Fkkz9E
 H/XqYaRJ7H4QxUvAcAty9RCRmhgOdt3AZfqgsE83tJcZCm9arPtrOGkQYbYfDzOUdCjpxR9uM
 jiKVP5DL2r/VKp09RqBzdQRjmdETPVRG8dbF0+h+Gzs2NUEHFOlM0xgjp74IkVIUKGPfRXqBB
 OH7eRDqWvpTY1dJigRaD8SJdVmIgsZHIU65yNOD+zjYRtjiSZNrv4rCiwRb3vxJcF1M6ygCfw
 inCG71Dq9rPDP7xcXjgpsoto/YT//Guxdh1pmUp5t6EqLefbQ2Vw1xZhB+RIi/3sRQap7tbpF
 BSm7Vp22Gwx+BzqjrfoXUR1KuX2yNHVleALfr6AT8w0MjZxmYHlbzzAMCc3nb4q7CYYm7eRZe
 yvNHl3tgzAsPYlP4c5fP3iP07wj6oqhlBqFPper4sKqp8gXR/VOjKKchzlkKzHo1HUC+0TXBK
 20+zTXv+VqW7Jvk5wsopICkaEWj/CE2z8KYHfA5W9urLmEAdL9oKNsm6fg7AP1fVzUxOPE3zK
 pg2BOLeRJLLmbLB2t5KgTbjiPo0n7trTkt5747mBKIrDVdq0c4l+rcjmxWU69+cLi+44uqesG
 ew+wIo3hO0GKn9TYl4mLSmZWaZdtunZW9wvdHmoM2sd4N8qPLu7JVvrJ2kxF3r8Nxtxd2HeEH
 K6BOz9LGyYCSpSIrd2wzO7KSFFMtYzC+NTPnw9F30wdzsV91zPj3BTJHi3jgCvJWX+sSeOwLg
 pCXFn1jvLYSE3Y6ldx+mpc34FInaHVtvgf1zh2S14B3zrWmevfN+4myiwTGVgI8KYLwqUGBI4
 WRhziHQKfaBgId/rbqQFM5qKZnKvDGUMa8wgKwgY/GPRJx0B5CW+7DWjDJkkaMlBHUahEvmd0
 KdsXXtttwotaY5T2sfyRo8wFOD5md1Q6GE63fc2ql5+nRoznrN3cPGvws0W4bhse30/y8sWlz
 OTJlup5tw5xcn3Luu2/CQg3sDUrEbGB4+TYBp03wX6E5qt9Kuj0KPQV12+3VBnvdoeVKo6JpQ
 7/hfONTlDicS2tuI331aU2tjJaXH5uJnIWNfN5pkMSgJCWQ8KA60W8fUWhbKqewM6gzAh9Ahf
 ry1PRw64cfsZTNNjwFafK46RfLRY+rfwqvxkGAhKFUAoLyk3p2ekbUxMwk1s4+mIB7AThtm7i
 UkNb1ONQNXwSOH96Tje5LAdr1z0uvpQBig/0MUSpe3ovL4NGcIFtxxn7xwIys8MUoVt51KDr1
 zo390oaelqwYxipPjtBZt5BBUq6MQmrwYlheU2du2DdlVfGimFnr9/5tYZZGgoH8Qp045YjFa
 BAWtSv5K4CdeUZl5gcB5mQUphVVMUIUbWPGU2Dfon/FcoZZHRStZ/cEjPXRkKTuFhjG2eHzUx
 x1V596LqQqGu1cg2mU08muzMXL2RhjsQwh+wlSRFxPKugUoMPAIHAAlR+30fEjrAt9UbfOkO5
 U1rOg2/dZfBY6JjSTVHZTu0wpvY3eZ5uU3X1cQfDFJHVYjlGOMdIMeO4JSvGMhwYUK4sejkf0
 YbEGLpeefTLziGNP518QePdz52zPVL4o9y+JoQIQTxVXyPS9zrA91FMxgLfgtqCfraHFJbd1A
 vZZWGgYGNyaBmF7ayJTx0FmXvL00bcyjPGxzMbw3hP81qLNxniGwfNy1I7vh2YGU2gaEZ0ckQ
 z4jnK1T3+5bFU5NsjYOw3mJsrw/TYzLA8WZyrEBOpNLEf3LXC/38yzLRmb6KNRSbBOuHnUKyg
 sRaca7LUAqj1E48rN6SmdnoPFOpOzoCW5mmFvwJAEEZFriKLxiVeMszI+mffgQs58YlTjV+IY
 RJI3vTuKIIEhgP8K67tO6gV+tAbDoBv0I4yISgVXQd7EAx82Pz0o/k5YmR8FMndcLgIBQKDRb
 syfcwoJPiq/DZFHWdHKE9VWbxuC7NFg4nVHkhy29/Fx5va8d7j8n3F1TD1q5nyGp4tf4AG1nw
 m296nKV/MlOzUlK+g/FGuyXAjlFF6OTIPnjcTi+5Zq3oOPc3iT+5VYl2zZIo3wRcOB5Gtg5el
 wyaKH/r6DdSNW9lG2KZZ9lsULQz949hLIfOyKIlZC3dIhVIBo82a5Vr4af3gY0s5li45pMuh0
 /Ci+OpDoxzgZuDo2sJLI4Wf0JNOF/NMtp8eVXj5M4hwLBM9GXp6bsOG3nhdY5DYpjoPf7nKum
 2nQ2pTkVrqk4h76tfyWsjtUp1vygB0n5cVkHSpHwwGBFd84ciT8J5/eikkjIMC/5qtH2DAk/L
 ydkaJijJfB5MvYXGbphEspcBiRZnCBOJBMdLBmoJQmtODVVGuFrPJR8W79SYflSq7JJ1a3eOL
 BOjc9LMkOLzbP/V4+R0d6qFLjPQbbRJ7tS+p+uayUWHlSXTqK6dYYYNGtKgZobBFw6enpHDHF
 VUENUsp7OGIaDjbD2H3BHJAWKpjI+ZrlQ4ykKme0MGaUIYgwLMNg+2nESWZYrBeMzv6CPB9/T
 4Nm2rucZTVLzqMg377ukxP08QgRE+FDKVUWU0eXbyB9QXc7fn5dUqv5uaIHJpOhbWAyI4ymZu
 J7YRrUE04MZvnbWMwJNfkMa+/bHzf17ZiQvwRuqnRyAxw+Ixz429QSucCn+6z+1IhseGqk5lS
 h/lzUQZWTeczYxEx9hUXbxZxoeOXjMn+SOeVnFm/vYGtA3gR2xzNXJ0YP4zvIpwF3ZlNhRkJF
 kee9MXGdG45MKtGbc0+/s7uZZpbqYuLgUwJ7HSwrNz+x+QuYBPRcIprqqBzmWTDsv8VFrbtIo
 mjxLb4R8BpSxe0ByELFIMpDlPr3VxXvKmvHMy2mO3k6Lk8KiltuW8NlXEXfumNGjz6GFXU5iT
 NWBwZDbnERq87pr2t+I358C+vOleLVFRGocKM/cyby/vU+H2io74wNNuhDN2oh16A1TZCE9pO
 5/3/qCguMeQ/PU7+VoSC3bl13WCo3qhkg4BrDUr5pDFe/SOrYbGWO3YCVB8ckLkuswBipHBxG
 RSY5Yk4i+W/Ied4+97y8Q9cb5Jsk2r0grUxZy8szking9yyNowhx8q2fk54d31X8OkvRRHQV2
 em+udZ+XuYPjl6vQzGOBCpVQXmKpIMLWQr/2qAok2nxxXxreWqiVrQuwbI68yFQcUU1WqDgrl
 DuSM/lYV84EtLj3NPbZz8euZBXNaWZIwdGN/wjpE5miUuxg6gBE5EHfyQlGbAeFHMpbo4L9as
 1O3O01WnQrWUp+bicgPGnW1s81eWvMjZo8NJozwE2mk1HAPyYeDuXVYfr92tY+6ZBzC6KMMHG
 yS04D6XoBQEre3RbJWF19y/s13s0EFBmBF8Ujm82a6q7EgqO/tt0rphgrEUXcWPVP6Bkqi9KM
 OFmGKX6GA6pV7jAVtVzA2JOGfv+yBWoYkdKMwuZw6C2Xn5JBzZV3ppK+q6sevG0wSg2h/4Ui/
 XbiG35bvVQJyg6fu2IaFdgQoJRlQ97GSsyh2QUHvY3WNOGtHlPy+G0e/p/hEMhHLcmEM6HinV
 YFX5/q0sRrsyE9reonRmGw0shmmQQtPCSjTRVwhmeWz4J+hP69tLbsZuBl0gz12WhDkrjYpOV
 yKv7N11/kPMZrW8tG0odZJICC9xrFuhhDaMAy9S+P5o8a46y2JCmqfCsgjjHuhX/Sm+4sJYAY
 r4V9ZUHoiLAMm0pYVn+2AMkXhrZ5TSF9+bhJG7bsfRamJGjtauVXCwLcrZQLiphJZq4yb9Ju5
 w7A6WnAlT7Nuih5Mv6IFdncTv0+RaAiksF6EaDOOX1kYptBQs05vW59GX4PGF6zwgm+UbT3gr
 qcb+G4hh8zTzVgDvqy4ish+/DRuBZ9Vc82vH2CCf/x0NiQvpBoK07DOpb1qVQn/X0zxjI7bEC
 57g9YahO2PNNoWHTIA4H6320Zcxus2/dd40HR7h9FlDW5SPBr84jWPjmIk0qAEdr/L4ZqKQ3/
 7ip6l2+8LkMyXa0qzS9DyjQ59DATXpI47NKrHAMjIt146Gr9lxd93lPaaXDCz29pk/D06fvZ+
 0k2MltQ4efl39AXcptHrpLDZfCHIgac1lw7nEj8vW5PVUlbsjBN7Jrals5O1AEzInB8qWkWuO
 PlNtjTsj9fUKdOndRG+y6ExWMkhkmycFhZsPYUjnfCLrR4i7tXqbsCnMRitlUAMpaGI4GVYxi
 hTFZbXtmH2Qwyu15ZtKFgBrPW0aGmrKVHIM7zTwF7yWRPCMnhyj7sswJgeoKxEM35mHt1QzqX
 6+ZntTTOCdtJMiibsPw/BvW1kS1VsDMJYoh1mCDZLTbE6M157k0G8AQPn0jIqURWWpwsmy9Yp
 PN8Nz9Q6jzRyOzHFTff65dHxFdwIUySfb34d//bNuPaJVwlLPOSX7pYr9hCFiICdZ4Y3egM7O
 M7exAvS1uB2dyRMdGbhHToAZDgfYgn3J6Zejf/5WxCngHpxxIiSXHPaxBbT3zLWg0SRpws2hQ
 vMMUGtmoP+lRd1wTsfWbjrb1vp+Plx5LwsyvN6AUf8nUWT2bt5luwVnS7Pze4M3GRX6bKsR7E
 7Td883Tcx4u0WqQcaprt4FzL9sV7LTcKBKxMfvebTCcOQddBLbxwBa/WrAMvLQmuUiVepw05L
 JPjF1F5g3AP2BDE0UbMKBu47eYMKOfIm17ok6J/XvxxjmYilsWBRIQLkCLF1JaMi6OsGiFs7S
 40PtzOZatEeLsAoSBnw7tsJtiQaTDltHIz1U7eG1KUsC4RKhmats8+xxKoEAntKHKEF95NlmL
 llkwYChS9fWemw6GBbcWMEZuqzJv6rBdgKf4neI2Qx/3vJref8xM1ADDm93a0uIJhgK2+RvJd
 QupoYJXFIWnFWu7PBccoWYYO7hobOchRfNnJWfUuCFr5WTQ2S01f1XKRANhlPTqGknfVwq6se
 1lpyDYagLeJAI1Sf8OqY5FlkCgM9tyjDqNRDYbxtY7t8KDzAXicNKpef8Pctf4zJPdDJZUdQo
 AnBsQ3OF+53HhR43OWD5kdYYQ2hNuSH3B5P+C9BOY5BZaUqvgc07sV/NJYYbx+VYMrGfueOhU
 EsK1KEdhCKnIImpHdwXhoUMcUw39J1BP306fBOAzCVy3K/K0gvNge8PqYrQoF4pIAK0WHKeJc
 wwi8zfTDTgw0Z0hEhIU+XL0JubFRmSX+I9F8YZHR4BLB2xYAcWoFOETygta8mqLKQGmQN0PNI
 OoWjvl6tc0+RBZi3I+fygIa+zGHhWNqJweMzpZhVbRvFyTSxnJgmpXPAc=
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks for the review. Addressing both points:
 - The unused fallback_vbios/fallback_vhdr are now actually used: the =
first device-identity match is recorded during the pass and loaded only =
if no exact bus match is found.
- Collapsed the two passes into a single table walk, keeping all =
matching logic in amdgpu_acpi_vfct_match() (returns 0 exact-bus / 1 =
identity-only / -ENODEV none). Matching behavior is unchanged from v1.

The patch works on a live system.

---
When multiple cards share the same PCI device ID (e.g. RX 6600 and
RX 6600 XT both use 0x73ff), the VFCT table contains separate VBIOS
images for each card distinguished by their bus number.

The current implementation iterates VFCT entries and returns on the
first device-identity match, which may not have an exact bus match.
This causes cards to load the wrong VBIOS image (e.g. RX 6600 loading
RX 6600 XT's VBIOS), resulting in incorrect clock speeds and
potential system hangs.

Fix: walk the VFCT table in a single pass, preferring an exact bus
match. amdgpu_acpi_vfct_match() now returns 0 on an exact bus match,
1 on a device-identity-only match, or -ENODEV on no match. An exact
bus match is loaded immediately; the first device-identity match is
recorded as a fallback and loaded only if no exact bus match is found.
This keeps the matching logic in one place while still supporting the
device-identity fallback for systems where the kernel renumbers PCI
buses.

Signed-off-by: Matthias Kesenheimer <m.kesenheimer@gmx.net>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 41 +++++++++++++++++++++---
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index f9315e0472fe..ef9fd98eb9e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -441,7 +441,8 @@ static bool amdgpu_read_disabled_bios(struct =
amdgpu_device *adev)
  * the bus numbers disagree we accept the entry if the device identity
  * matches.
  *
- * Returns: 0 on match, -ENODEV on no match
+ * Returns: 0 on exact bus match, 1 on device-identity match (bus
+ * mismatch), -ENODEV on no match
  */
 static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
 				  VFCT_IMAGE_HEADER *vhdr)
@@ -464,7 +465,7 @@ static int amdgpu_acpi_vfct_match(struct =
amdgpu_device *adev,
 		   "VFCT bus number mismatch: table %u !=3D runtime %u, =
matching by device identity (vendor 0x%04x device 0x%04x)\n",
 		   vhdr->PCIBus, adev->pdev->bus->number,
 		   adev->pdev->vendor, adev->pdev->device);
-	return 0;
+	return 1;
 }

 static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
@@ -474,6 +475,8 @@ static bool amdgpu_acpi_vfct_bios(struct =
amdgpu_device *adev)
 	UEFI_ACPI_VFCT *vfct;
 	unsigned int offset;
 	bool r =3D false;
+	GOP_VBIOS_CONTENT *fallback_vbios =3D NULL;
+	VFCT_IMAGE_HEADER *fallback_vhdr =3D NULL;

 	if (!ACPI_SUCCESS(acpi_get_table("VFCT", 1, &hdr)))
 		return false;
@@ -489,6 +492,7 @@ static bool amdgpu_acpi_vfct_bios(struct =
amdgpu_device *adev)
 	while (offset < tbl_size) {
 		GOP_VBIOS_CONTENT *vbios =3D (GOP_VBIOS_CONTENT *)((char =
*)hdr + offset);
 		VFCT_IMAGE_HEADER *vhdr =3D &vbios->VbiosHeader;
+		int match;

 		offset +=3D sizeof(VFCT_IMAGE_HEADER);
 		if (offset > tbl_size) {
@@ -502,8 +506,15 @@ static bool amdgpu_acpi_vfct_bios(struct =
amdgpu_device *adev)
 			goto out;
 		}

-		if (vhdr->ImageLength &&
-		    !amdgpu_acpi_vfct_match(adev, vhdr)) {
+		if (!vhdr->ImageLength)
+			continue;
+
+		match =3D amdgpu_acpi_vfct_match(adev, vhdr);
+		if (match < 0)
+			continue;
+
+		/* Exact bus match - use immediately */
+		if (match =3D=3D 0) {
 			adev->bios =3D kmemdup(&vbios->VbiosContent,
 					     vhdr->ImageLength,
 					     GFP_KERNEL);
@@ -516,9 +527,29 @@ static bool amdgpu_acpi_vfct_bios(struct =
amdgpu_device *adev)
 			r =3D true;
 			goto out;
 		}
+
+		/* Device-identity match (bus mismatch) - record as =
fallback */
+		if (!fallback_vbios) {
+			fallback_vbios =3D vbios;
+			fallback_vhdr =3D vhdr;
+		}
 	}

-	dev_info(adev->dev, "ACPI VFCT table present but broken (too =
short #2),skipping\n");
+	/* No exact bus match - use the first device-identity match */
+	if (fallback_vbios) {
+		adev->bios =3D kmemdup(&fallback_vbios->VbiosContent,
+				     fallback_vhdr->ImageLength,
+				     GFP_KERNEL);
+
+		if (!check_atom_bios(adev, fallback_vhdr->ImageLength)) =
{
+			amdgpu_bios_release(adev);
+			goto out;
+		}
+		adev->bios_size =3D fallback_vhdr->ImageLength;
+		r =3D true;
+	} else {
+		dev_info(adev->dev, "ACPI VFCT table present but broken =
(too short #2),skipping\n");
+	}

 out:
 	acpi_put_table(hdr);
--
2.56.0

> On 31. Oct 2026, at 11:37, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 2 potential =
issue(s) to consider:
> - [Low] drm/amdgpu: unused variables in amdgpu_acpi_vfct_bios() break =
-Werror builds
> - [Low] drm/amdgpu: duplicated VFCT loop in amdgpu_acpi_vfct_bios() =
and dead code
> --
>=20
> commit 50a61733895d9903e897b70fe18231ffdb69f9ae
> Author: Matthias Kesenheimer <m.kesenheimer@gmx.net>
>=20
> drm/amdgpu: prefer exact bus match in VFCT VBIOS lookup
>=20
> This commit updates amdgpu_acpi_vfct_bios() to perform two passes over =
the
> ACPI VFCT table, preferring an exact PCI bus match in the first pass =
before
> falling back to device-identity matching in the second pass.
>=20
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>> index f9315e0472fe9..0cee0872100a5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>> @@ -474,6 +474,8 @@ static bool amdgpu_acpi_vfct_bios(struct =
amdgpu_device *adev)
>> UEFI_ACPI_VFCT *vfct;
>> unsigned int offset;
>> bool r =3D false;
>> + GOP_VBIOS_CONTENT *fallback_vbios =3D NULL;
>> + VFCT_IMAGE_HEADER *fallback_vhdr =3D NULL;
>=20
> [Severity: Low]
> Are fallback_vbios and fallback_vhdr left over from an earlier =
single-pass
> version of this patch? Neither pointer is referenced anywhere in
> amdgpu_acpi_vfct_bios(), which triggers -Wunused-variable warnings =
(and breaks
> builds with CONFIG_WERROR=3Dy or CONFIG_DRM_AMDGPU_WERROR=3Dy) when =
CONFIG_ACPI is
> enabled.
>=20
>>=20
>> if (!ACPI_SUCCESS(acpi_get_table("VFCT", 1, &hdr)))
>> return false;
>> @@ -486,6 +488,44 @@ static bool amdgpu_acpi_vfct_bios(struct =
amdgpu_device *adev)
>> vfct =3D (UEFI_ACPI_VFCT *)hdr;
>> offset =3D vfct->VBIOSImageOffset;
>>=20
>> + /* First pass: look for exact bus match */
>> + while (offset < tbl_size) {
>> + GOP_VBIOS_CONTENT *vbios =3D (GOP_VBIOS_CONTENT *)((char *)hdr + =
offset);
>> + VFCT_IMAGE_HEADER *vhdr =3D &vbios->VbiosHeader;
>> +
>> + offset +=3D sizeof(VFCT_IMAGE_HEADER);
>> + if (offset > tbl_size) {
>> + dev_info(adev->dev, "ACPI VFCT image header truncated,skipping\n");
>> + goto out;
>> + }
>> +
>> + offset +=3D vhdr->ImageLength;
>> + if (offset > tbl_size) {
>> + dev_info(adev->dev, "ACPI VFCT image truncated,skipping\n");
>> + goto out;
>> + }
>> +
>> + if (vhdr->ImageLength && vhdr->PCIBus =3D=3D =
adev->pdev->bus->number &&
>> +    vhdr->VendorID =3D=3D adev->pdev->vendor &&
>> +    vhdr->DeviceID =3D=3D adev->pdev->device &&
>> +    vhdr->PCIDevice =3D=3D PCI_SLOT(adev->pdev->devfn) &&
>> +    vhdr->PCIFunction =3D=3D PCI_FUNC(adev->pdev->devfn)) {
>> + adev->bios =3D kmemdup(&vbios->VbiosContent,
>> +     vhdr->ImageLength,
>> +     GFP_KERNEL);
>> +
>> + if (!check_atom_bios(adev, vhdr->ImageLength)) {
>> + amdgpu_bios_release(adev);
>> + goto out;
>> + }
>> + adev->bios_size =3D vhdr->ImageLength;
>> + r =3D true;
>> + goto out;
>> + }
>> + }
>=20
> [Severity: Low]
> This isn't a bug, but the first pass duplicates the entire VFCT table =
walk,
> truncation checks, and VBIOS loading logic of the second pass, while =
also
> open-coding the VendorID, DeviceID, PCIDevice, and PCIFunction checks =
from
> amdgpu_acpi_vfct_match().
>=20
> Because any entry with a matching bus and device identity now jumps to =
out in
> the first pass, the exact bus check in amdgpu_acpi_vfct_match() also =
becomes
> unreachable dead code during the second pass:
>=20
> drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c:amdgpu_acpi_vfct_match() {
> ...
> /* Exact bus number match - preferred */
> if (vhdr->PCIBus =3D=3D adev->pdev->bus->number)
> return 0;
> ...
> }
>=20
> Would it be simpler to record the first device-identity match in
> fallback_vbios and fallback_vhdr during a single pass over the table =
(and load
> it after the loop if no exact bus match was found), avoiding the =
duplicated
> table walk and keeping the matching logic in one place?
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/6C5E74D6-8F98-48BC-9173-7E85D243B3D3@gmx.ne=
t?part=3D1


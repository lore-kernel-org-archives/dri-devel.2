Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796AF606A33D
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=g6H/kYv8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBCFF10FF61;
	Thu, 12 Nov 2026 10:02:05 +0000 (UTC)
X-Greylist: delayed 309 seconds by postgrey-1.36 at gabe;
 Thu, 12 Nov 2026 10:01:59 UTC
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01EAD10FF67
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:01:58 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1794477717; mf=PGRlbGxlckBnbXguZGU+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:N10apGpguw0r0b0SyT+7HdFCSfXW
 T4wq1T82ELDIyoZS0nii4z5Bm1GUT6LRq8WIIaAUSVMLw6iWsvd9WDsjKJFTgX/aEjz99ttBIxO
 /t0AXr4g12+XPVxV00c6jQ6g22eNL89UNPkKjijoaOaENTv5K2VYeGD5eTwFXckOkRj2pgqlcjo
 vqZY1FNtAaj6BVmy1Bo0eo3cmFAIMC6HkGIz+Ki16m8Xe0nlg3zPifI6QfMmM2l8MI1XsiIS+7u
 tqLiFfg5MUupxfvyK8v8UJuDor/eZTybJfHw5SByBEyPpkCsRJTRNkYwlW60isXFtnFOZgNRi52
 IAkxzrd9BAK2jg==;
Message-Instance: m=1; h=sha256: Of/fbooI0HmGM+aGX4VMVyRSWXodhZmJ2hfcPulyUVg=:
 /MMLbbam3B7knaPSkDd8A4WNShinmpMcL9o9lq+QpfE=, sha512:
 fm5uMoTNa/yLDuhF+urb8LsTqQBiX376MtUKuZtiEB0VVUTyFWYg3F4TE7byHJL642JwwRP2kKbSpX8uew+iZw==:
 W/ZA9Opqha1flGXMt4vCIEuToQEahK/6GxwYrcd4lUMseTkCWA9JiyQCf4/ydDwmjbcgw12Ni66DK/IYl7mNDQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1794477717; x=1795082517; i=deller@gmx.de;
 bh=sZ1t4uATYa7cR4Spc5Z083HpP4Ftl5L9B64B7O16jSM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=g6H/kYv81UCheCM9UdrZo6hYGAj1RzCT6e4bnu9J+wZfSZuHqpKwl0aLnVu4RO/j
 kcDvN0Un21av+dNn3JF6cNa1L/J1QhJK8tWBwwd2OJlB4FQqmiGDtgnMiqxHS9791
 actR8MQ/xgYxIzcr5gBix0O3dj16CYjV4Bbu0GIFdhmtXrgH5k/8pv3/pnadridV2
 K3S997y6kgIF/0euds9MJMGo3+s/hIgOoGz+cqcJHtup/LpKmcZAQasuwTRz4yRVy
 JWO8U/UdRJ+r/UODTbBctTeyxiVJSYbQqeu/Tejxxw5S/lbhisOwmExO8MRnZRkp4
 TvNYrNOivhsC/O0fmg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9MpY-1wMKIa3usO-00tUMY; Thu, 12
 Nov 2026 10:56:37 +0100
Message-ID: <39ba3f97-dc6d-49ac-ba72-8c2b7c6b0250@gmx.de>
Date: Thu, 12 Nov 2026 11:45:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vgacon: Fall back to the dummy console if mapping VGA
 memory fails
To: Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
References: <20261111-vgacon-ioremap-null-v1-1-6dd05bf390ef@gmail.com>
 <CA+=Fv5SHTC9XWQJZY7DnZbpMPnk3b7eYNiiH6Dnii+eLJo9YgA@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CA+=Fv5SHTC9XWQJZY7DnZbpMPnk3b7eYNiiH6Dnii+eLJo9YgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nyEnrrW7rXdR88F9i+QtQ/SGD40MZUyTyZjrzWU27JXhaS/WsAC
 Eltt++jkysNgE9sMgbTImj8XyojxXZLqkPz0XrZEY2diNKm6faQK6fLCiQqvFSXEwrE/WGe
 Xsq9sEC+seX32EaPERUvb3psnhu8tJD3Ngo4GPSUmqztcBY/ZBin2X1FXU54ahNd3ZnpqqT
 n5JW0iqZFdxdKOxAtmFtQ==
UI-OutboundReport: notjunk:1;M01:P0:2gJpG4ZNeYg=;Vq9+1RTcLOE2lfwov00saJ9eOQD
 /1VMXyEQp3uUAItbCmRrzBcvL3PwsWa9LiXUSYHLE/g80oeEQRVnUTdMU/9dIWWUk2R2z/+BN
 JlvRIYjDvUNFlD4yT4WNBe+h0pJase1lzOC9Jg7xYevPVyJgbtrG7mHvNRKlCNR1PxKsgfUB4
 w+MxphYEqlHARGk9hj7Sj2sH6fCZL8GF9zDEfyRtIsRtjlkc3askqTvG6Jx6XoWHcjvGaHgtU
 KqW5j3XEzlXfKMpcg7A999umq2OT1Kmtkpjv5naZE7iFba+WUGWWJvuIcGFeWmpu8DwLy4TvI
 xPMajgJOGFT+ygEI4x+gHy+OvsCBlcMx9oEB9cCwdCbFtmkxdRRK636ySKhAlNf+ymgH+sby0
 1bikbrjuLhTh1Kw0Ez3s2r4iKmMWLl7wLT1Ng26pdTpB4e+W8j6M2v+by8x+sT4CQeUqnEO7c
 mthVOlUT+gG/c93t2n1H5ei4vaZuWN+8YXg4J2QI53TIgTBdyzMmltupixQghq646JYUr3Ok3
 R4LZ0XwOEW34+wQg5sDpGc3KfO4M98D8SWv8g4Utu5ZMBl7w4VnowDf+VFCtsbTFw8I/wDClL
 Sh8sadWeZDAqsyziwRagMWI56GpIpaTV0KxtM0YcvQyxBGpOy5DbTM/xdkvwKgScBODzX13Qw
 UQh9OqsrRk6h/TL8Uq50rqDDSFrwqGwIsw4XnneqEP3tSJ9lRaaqJ50FsN6iU0NJo7i2ipy3z
 W+fH0DHJm4qVQp+pbUBWTghQFjJwHJ5tzvDidqgVLhWz1jfh9VUwTyoS2IeGc3+Z5LoPD3+s9
 JXhdAb33zjjAGMl9uGTP447oEWlFZbgsHx0bU9jHDAlrcACpDNByk+8LCK8zxB6XYqa37+WO2
 5hPEryGYfU97OdpLRsut2hNyKaeGXu/GKimquLKP+A+Ik3Wzto/jN7WKVptBUYp1TSmxd3YKF
 lv+aTd9DXomr1oVqezWtXAajD0YP9RzaWKf+aKcAuDlNOazFGiUU5u67ZbmfYWJwaCndNikN5
 GO4u8aWOmiw2GHp13cbI5ZkVhWAic4BOPUPQb8ptgEJBhlggO4qcg6+p3KB7NWqUaS+t9ORQ9
 yDgxJQn79pYvJ5kESljH8XUaih3gmJcPrEFYeRAQZXvA5NsiAworalPx01ZM/gbjuTjCSlS5u
 Nwx76sR+ysnBDItwagojix6QM0sPSNJsgMtTuQxZ45/kg+Zw7YEVlsky8CM2NW/ZDVLssdbCD
 cWFBMY3CB7tyZfSucr8bKvisxADADAYoHANAm9xwHS2j5oLyVrXlQkmHxS8f/v0gavfi4H+ZF
 /1GOKcz5HO0r9ySHalfHVzVVcW1tqUoOLqexbB2EYB1zMb4P4qDPn7HJ4d6GnxwNj9Cqnqovr
 HqosRNmeytRTmkdiGau2km14uNPqszonyhXk8tWWagCJqfxnhpKGsdSEiXd8lt3QEYEDThaZo
 B3YdVamUghjUjdTH5JMxqFhHe8Eo8X6mD9UD2ZCWtg9SK3u4miNPt6wZxbwI6ZJKXNAhKPuQG
 YIW62CpdR6151K2lbra3UgC4NjXscg5ygosNqBefwM/PX0+e67yyr8hBVTW5osT5RD2xKrLiI
 PWRVUaY8/CH3f4LCCuAFgfjSBeUcSwz6rdzD0tPghSS5ZiyCka44NFfxWEGuZnxp0hYIA9IZo
 QoBmOh1Kzfkq2BEE9CU22IyF6V+1Dyc5uPv6IIyMYycTPnrc8iRilfn44xJSAktaaAOn5EWlM
 82BdF266oiXuQBgob7YDb/q7t2h6Z0ULUTc4m8Ipy06ahJKpqZDB/ZarEzskxCSzK5zX4fWtS
 2qecuoXEFzCPSEKy7E/jWc4fJwjah6jifdfMzc0cbzp/H/J8rFMP2LirCTUWqojonyrUROB4/
 M8zFYZWmbBVuk+vdGy6PidbImxbNr1tGQINAwc3l3567PnV7or+19DFqGakwkzpcoZTWFqVT+
 lIH5IuYQHIfWWjLj0if/KzthFDxBcXEzFdtOu0WtLy0/a9mpLPdlkAIyM5TfCuoZhf7GyxBZB
 /ROSnhlN8K7Cv0IkhaU3SVaWtOpYuNKlQ0tUUAZhsFIVBibO599zwJz8ppkfwg3Pzk0Y7iD+W
 YaqdRFJZ/USnKk0qyVTqOEPEEPu+YDXtPiMUpg1fEofAyk9peF1s2QFO3ukxPyQl8Qudce1v6
 BfYp58Xvylf87J28MkHvQl8rFLkRBr4PQx+Z58FK2ijMCLjdia7xHeAzQXUjGNfpPDdYGggex
 lypACSHHLAnQc2HDqt2mCbKWF0tbi3puMEeZ+NVyggFe7A1Pa2hyxOKE3DayA45FQQfjceAao
 E+W/89rSkYI/q7SDnE1bKAn+x+VUSfsqc9ey0Jk7UK/cEu0/iI75r1UL8WPZpw3bNjzJhE1e7
 UD68nVKU/hhuOQi1F6zP5/EAy7KBC+t2TmBylfhU2hMnTgKEPj5T5sGknLxcnx18kMBA7+6d8
 JkkeawtmBHzgL9JWMQmfE+bBuitD1iLpS+2FsBW6CvobsXwF9Y0YV+V1AYlRWUbr/WDYyYlCu
 SND6/ECy093ywEwJmIHq8yDr/W06SKgj8nzRgbsSzdyaJ9KiUW9cKVIP8B5H2/KCipwGL9YKh
 nG97Mmi92zDcGg+l71fhjCjtyL3TS+45MBsmATALhEIvHU0FGgDsiLIP1Gitk8ZnMZuES1iDV
 hDk+aiACNuczEZikK+g9Qg0wBn8qZVTI9g8lOi2YlhXhanqv9FpOZ9L193IbLbldb6UfDDIbQ
 P2UcIutW/TIvnuiHrhiDwTi+iHh8cySo0Lk/Fo7CJ2PAzyLTYDRNlgw34njfZ/gWuk7UQTp6n
 4rb5e+tI9RTATr4I34ZY8wtJzwgRHrNknbb0AbYMWiYShTQcuh1OssZm3hE+TBfJcItzZCAjm
 DMyYaGoaJ79jea0arejYi6ccU6pftcxQ3cK0NJDOw15uEI5pNlbi1NgKl4wmprcL3BzL20o8v
 LK5GLG6dMmIyJ/50Smkoj1jBfgTvEV+mzF8s/ZAwq5cIXgzHATK/73woLie+PDk+GCiNrxdmG
 uDMlU5tShSu/dRGcfvf6+uUSzpTTZY9X5deP9yaqUrJc3UzpKT+inGrR3sTd+VwcYiejXypi9
 fYotPXSFzujFNzBhJMe8tBuXFsnmi/0ghwGx7IigcsciQqExRdc1dHz0fHVeXfpcljja2yd7U
 gmJjusMo8XR5DqiSeLJKOVhMfb3pOrz6wE9KztSh5TjYCWADhytBwIYUByVm/jepnxUXpw+ua
 WVSD8nt4gJ2hfM5P7Nj0HLbITcq/QaVVCzisJsb87URSt1d3A7JAo7Delwkh9Y/vtvlrynCyq
 ql01cAujYSsxS3zCES6TNY9NvC/5RfAY9MHaqFBqbgMFkx+0s9sV7KGrEXwIPW9UKY8qpEmhf
 sJdFaDrjqWA1CUpERutmVUMuPd/Ev6y7rEp92UScrJyV5S8jxm+M6gyr3ZIY+as+v5o8tz8oU
 NS3UN7mgdq5n0fO/fRJrUaqxGDe6IdId50tzoY0h4t7Q7ZRfQCRAy04uTK/vzmsPY2A47nyAM
 eRDUqvYx2D8GE+/mAx1bFR61kICTIsHdCq7lWto48FEaVZyv3c2YV9kjWaqDGu5OSR+Kbx7Hi
 BbVF4rpd7nLRG5fnaxTM+wc+HMNcM6/H3arXO3/ypyyaMz6FHy9jU5dPU+DtlkwXYzN2J+cit
 KQO9ClCcYJ4hCZb8XOPJW6QdNF3ImA2HkD2+wsfsgsBPTyU9ENnXmcPtALqy8TUvTLNR7sTqT
 VA/oVEkVdfypBj7ApIViP79gKeak1o2IThWgSWw6I11+mRlghhBe2evapgurzccM/4vzZlX8T
 8hoC3+g9NHOZQDiIkaQSCnxOtW73i/8pB9mBWiqjzh5KdTCW0h8MfYBw/N6BI7AH6YTCjwQS5
 6odVHWTSGl7qy0KsHdcK9fjn8fKdt7+6pHMIW2//9w0B5IFHTe7GBJk56ljGG3aBQHS69ljoM
 mINLNp6C0S6eewfLn4dm0u7fDOaqOpUSzcujr3UwLXUcU8L7Rz3szaUT8j7NRArBnI4g+F7TH
 hV0aOgFngNfdV+3Ze3bkYkXoXdu/9m7iTdkx+o+rHNDbi1KcaiCl14zU4vAqc0E8umgGUdqsP
 Tq/bPfZ8qEjw+TvTIum0AWgIBicuGgVbr+aSaQB72WlCu9zkTzHWkNoS5hcdqcLF1c2RRpND6
 Rxv1zqh4Lbd+/6KqcevG3xEAVChxtV8su+kfzc/d8++jye+pM18AWBv/d4RbzkaSyj2tvFoMN
 hws4Ay+IU96oNkX9XCY8JUTVV6Hh6p6H0LeYmk5hvzuMMRIu3rtuAKUdmeJdFvEO1xxcfStGL
 KwufKckpCK6wQ8Ko2dRwvmsZrAS6OzQCc3uUMPoKP5zAreKhLyNPc9OzdlE1rzD3hbxgcTfx+
 vi0VbWrGnQWwR1bf+ykNq7e9oa4GJ/6MAwW+objSc3ECZfs3dtrNc8UPOncLLF7Lp1/8iAKgq
 X1PTeYhDyGBpS9ceRmdrNUbN5gPHmE30I2ytDinGhQiiD5Nv1mMw3yiuSe5INppsVd/JdlTEe
 u30AoQgHhkb6UoIpoCCWei20dRlsG29JNlUjgseyVPraqfLZlvx7md0Di0bTOMANmaD9JZNVt
 3Yv97hVOoNpSgBXnMn4Yeax5BnVNgasgIGNgY9W0o3UYxVkcX1QBtBT5OpT9JnEZbzYCnTS/t
 tZ4HW60+fz2Q4Y2vBygKyduN0RbQ7G/w0yGz00tXOH4a/XPN8Ao/CDJMj2ILV3UWgYPCLrqGB
 t1H/EbOxahcBCScnFewVVkTpPtp1kb33nv9JPbotq70slFNjF1/aF/tvMisJYGCEcyDRUhfaQ
 eOv/o7NTlfWnPTUqz2Rx1Iz1T29HW8GLgBXXVEmGttzGFQgR0rOJ23I9jnpflJBA7Um14G9Ev
 +x9Jbr9Swqp9u+t+cf0B00uG4zg1TGSkWwMKXZrOXZOEpPJ9PiRJKTueqrztHKnPVhMx8h9gh
 5UWgH1FQKZmiH8d0wwM7iM3ZdlrhjJvJMLpyq79hLORQ3PVJBUvbaC2moXX7FjR2qT/RAOjsG
 SWWeTWMZltcwfsF0gIi6Y+7X3vVWsGOcyQs6kznLmLo+hX2lkr97QpTueMZR7tlJ92+Y85AV5
 M7HdgAJJKGszlL/ekX5Xmj4z/LWTVh3tIHASVzZDQNyT7xVC5hv4XUL75KpbYi9wxWGBXm6rO
 AUi/lTW1vCr+V3nDnwA1JNIZLku98lV5xC73aJtweDE9lJTPKPt0oHCMpMZoSBbT27FT8obIj
 EHF3q1AmM9tncUzdPaBM8fZS1umyDM9/e1PTP5Nm+12BekKU7XnAYZfbA/UHVAM3fPPScAJXq
 Xq2aApWP+BW5MAHYsqY8nBAJSmljP0XRmfCESBJkpgPP7grLQjoZeed+TVvj2K64EwoEk8TOk
 48p512dqcr2pw+gQn5LQ7epE+DFGGvwEomPtn/xCcbqBPRT+e7Vo0WpJWOVe7Ogx9kD68K/Z4
 P4xZtzxPtCJOXjDEWAJZOARknzVQsU0VZ8eQs9UHXlsBgOUs+A63BnN0Mtnrgv0E93EDBwYYj
 58oGkoxUmTBB8wqqhmvYRbrl7sbTekbQapgUKHQoGCDZg47fAwh79qW3NdtYq+YEUe2TafoDI
 dDntUdgBhXnqzYMCUAiiwYsDq+wR3a3RcqxGYwabhlsml0QPE+ZLCRuiscJ8ysGnML5CliH/C
 2YP4hp9aNchC5wOZZ1VTg6/VqYxDMp9cVUJIZ16JcxAotC3VMoP6ovQC4P1VpwiZ0cNI3NJsT
 VSCRvovabFLf/BOAyN3BVAfCYHbdNe0WwrXnURLjlABFRoQNFfA6pnQTeAckSQlpbeyppr3FH
 fEF/oKOfZC0iiECbHOSVOFIEtEKHXR1cWNvRwuTFMfww23XFOI5UhLfuWYbpLdK2jgpIdE1zf
 FkiFwBnD2alQV0zdhDdP/VwALR0aqjliXa3JsewkMMg3nGT0r70UqLYoDGAx0q2xdxJvaiEjp
 aeVr9djkMoWWVEMTXd6seL2S7Mq2n4XCdYMtImNx0h0ovP7fRLejUQjWnssejTg2b6Hx7bBRO
 keL9kTo0MtSiiFyWC1wKZAxhuYZiZgPwpT9SZ3uRiKMMU9ciGKcd3l4GfIdD4tiacQZvQRxez
 KsGDWIu9m7BJiI9OKUiduHFFrbjiM4AqIS3cxo12ybSwLfQBdii6qUQTbwnMEFJCQtlN2YMiV
 l6UZJUEOZbXw9YwS1KMaUG6LPFeCLJbSau+ddu2yMaho0lMx89I0OLEtesiTWBFs/cKGCQuAL
 FwT6kjaUAt6NKCRmQTUVbkWbQr2QjHwXp6pP/m305uyIGafUiXJDo8WiN0bL9hM8B0fKCPU/U
 FtVeXozNckPHPhjE09CYa+nDOcjZe+fEMsvs1kRrzAWIF+LydzXOH/7McPu6E1hGc2en4vfTv
 oILFQcVwhfrcJHUDIsMHL2qp3hWj/nmBhoNO42o5wGg4DzaiPH04v7GQjTUfqsx5vGHGM1s2U
 LTATDJ4ldmsYvdevr1Ef/CP29hreaCP2Ih+M2pB5P2/TaOFU8Y1N7PeL+UOxoO0gPlqc0VDpl
 aiB6n/JWl9bwRnbsZljm6tF9Crusv2QB/3bENOpPyxajyMpQE5o8en+EMI4djshA1+hH2063c
 DP1Q6hNCFtF+R1bi0WXGzb5mwVPtqDwyhGob0lkZWi3f9SA3WMXeG7QvGX/alL2h3H203+u9K
 0KsEhUOqdU1fO1zMI4xbr6kB1pSD97zr2JwsApG1s5ONq4iNidnHTDpAaeMhk5K5aDp6xdHk3
 YRWyNDzzzWc+fLzUmBrm25P0tlgzMkwFPU2/kLpdu4q8+O9hNFAgyv5TjnBrqH552YPVEt5Jj
 jf/hmZOwyKf324FQ5WtYLaaa9/PJuR6vCSKAg+/ZpQsXMHm89hZxcggBvFvUd+cP7uqIMYlY/
 EvHsVvLh/RWoI4DFwKej9T9TSDNOh3qnWIdisze3020HrdL6JpjpovfwnzSj24W5+zalJ6eGG
 FdyQUhPHAPadJubJLjsSs3tlqgq7KmC3HwLB9FGKdN1MeLEfJBI2UJ5Hem2TRZVbrF+Jh0tOj
 w8vkEa/M5VJHoi6+bODyle3h/c+jrM5xKvyzgdQMOyQmnpfVtbqbucM2zm4aVFfI1dij5KpgJ
 GFdn5xmPb37XW3Xcdx3Rdpi8H0oM10Y8h5LMvxiUhWZqRmNdJjgX1p84VXxCiK3+krX9L+I97
 Nfni4IDK9PG7oSuMTwDJx2JMl4xv2fCPLQTZ2SuDm7eihDXAGmV3E/HJkgcSAiFYJqJmo3A89
 1kBl9ODnZFWRpeOhPLgVQV4MYcpNn8Kh7BRR7JDH6T8uYnL3hWgUrAN4WtAMtaZjRiIkJPNJK
 CwbTcyMhpM6tp+KVOMaGbR+3THTqLBCp4AgYx4ri8ldnc7IsyrJUde0Dq/8McbbjxBJNvVKV+
 9Eg1sy
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/26 09:47, Magnus Lindholm wrote:
> Hi Matt,
>=20
> On Thu, Nov 12, 2026 at 1:30=E2=80=AFAM Matt Turner <mattst88@gmail.com>=
 wrote:
>>
>> On Alpha, setup_arch() registers vgacon whenever CONFIG_VGA_CONSOLE is
>> enabled. On Marvel (EV7) systems whose SRM console is serial, no VGA
>> hose is set, so marvel_ioremap() finds no hose for 0xb8000 and returns
>> NULL. vgacon_startup() then probes video memory through that NULL
>> pointer and oopses in console_init():
>>
>>    Unable to handle kernel paging request at virtual address 0000000000=
000000
>>    pc is at vgacon_startup+0x174/0x910
>>
>> VGA_MAP_MEM() is ioremap() on Alpha and powerpc and can fail. Treat
>> failure like a failed probe and fall back to the dummy console. If a
>> VGA card is present, locate_and_init_vga() still switches to vgacon
>> once PCI is up.
>>
>> Cc: stable@vger.kernel.org
>> Assisted-by: Claude:claude-opus-5-5
>> Signed-off-by: Matt Turner <mattst88@gmail.com>
>> ---
>>   drivers/video/console/vgacon.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vga=
con.c
>> index e7e6750f1f87..09f7c376b468 100644
>> --- a/drivers/video/console/vgacon.c
>> +++ b/drivers/video/console/vgacon.c
>> @@ -324,6 +324,8 @@ static const char *vgacon_startup(void)
>>          }
>>
>>          vga_vram_base =3D VGA_MAP_MEM(vga_vram_base, vga_vram_size);
>> +       if (!vga_vram_base)
>> +               goto no_vga;
>>          vga_vram_end =3D vga_vram_base + vga_vram_size;
>>
>>          /*
>>
> ....
>=20
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
applied to fbdev git tree.

Thanks!
Helge

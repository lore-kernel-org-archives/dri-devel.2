Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F732606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=FjsQKBvI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4ED610FFAD;
	Wed, 18 Nov 2026 19:16:08 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57C5D10FFAD
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 19:16:02 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795029360; mf=PGRlbGxlckBnbXguZGU+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:KJgJTQSAt56/5XJ/p1TfdEzA8utH
 j6mQBuJ87f+tLje19H8H4gqdy5++9BEeze9y1ddkpKssqPZihH/eS4inFxa9wcHJKrRsm6Q6PIs
 KE0gJMXdhgDvVbaA3ARZuw5d1Yv8f8OyQsnFpHJgmHUo/U1KaPVcmp9mBwNGP6ngoOvDlxs9V9j
 fNHI6qRlyUQ/N8VH/nNhWT9zVIlvPjCucfDwEsdUpFTalUK1HmUUh2jBBx5sxsG8WrJdQ3K9xDx
 OkGJ9Te+k1LqLGHgsdI7UE3us7TyCcL2wze23WMXkBt5epi8DIcMHbRLxmN2YXyK4nb7IJgMMil
 mHbVZdvIfDGN6w==;
Message-Instance: m=1; h=sha256: srboCBAulFwERl214zNYkk1rtllxIIWloqWhuM2n22c=:
 p3QF7jznGO2+HIwtxtS162S1mgfk0qtMbWK073YbZPM=, sha512:
 dDveoLAUD3+QcugBd+G9Ujpxj0St5oDlXp+nQEzY2adME0PJdwVXcNL9pJJPA+oTWG7giVs4vSxU2Y5KiMqMXw==:
 Ubfvek7mviPyQnn2jO3s1k1tqDNN2BIwHBG/RqD546thQjLzpOxC7LbknTQw20wD1t+MDbK8m+aRLmi1Xt4Hsw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795029356; x=1795634156; i=deller@gmx.de;
 bh=991iyhXnePuoVyWUxWvdBH/MinbTCMVR+YpyhWJMibc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=FjsQKBvI2h4IP4cG0CRu/2Qixx1+KIcALY1LPV32VQMlbzap3OWe18QkWEGg51MY
 x1xPGshC1DP9aCWAuljzAX54g86YmlZG4MZvynT2k2/AQkL2FhD/h++YPUJMOxUth
 Q9GXiwwlZpFlmyUs/YVkaEenKMEHdILeHGCRCxB8t1xWpIr9dU+qu2Qq1aAiaN3bK
 tJEdhmee3ZYHrBkzd7R2AZJuYXarN8XxASc3J8hqb2Fa8CPOoddMUrRMYplVZ/zXk
 XkCI+7cy8AjbmRV1oe2dGSUzZtuU31rFHfrJ4YYxmggjkg/FtaXPb3nhuOWoi6//N
 J/DGERsPdinGeo3f6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtfNl-1wZjEZ0xep-00wSiU; Wed, 18
 Nov 2026 20:15:56 +0100
Message-ID: <96e0feee-1c6f-4235-a76d-b43aba44c19d@gmx.de>
Date: Wed, 18 Nov 2026 20:15:55 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fbdev: smscufx: keep the usb_device alive while
 ufx_data is in use
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>,
 Steve Glendinning <steve.glendinning@shawell.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bin Yu <byu@xidian.edu.cn>,
 Cheng Wen <wencheng@xidian.edu.cn>
References: <20261102072120.3022-1-25031212351@stu.xidian.edu.cn>
 <20261102085724.13456-1-25031212351@stu.xidian.edu.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261102085724.13456-1-25031212351@stu.xidian.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AYp1QqgTeO0FxgUHNaFIph2kqMo3jTA9nJaUxIqXg6kr85UEvFp
 ll1vS97irlEcrlC00PUSXfOvjlKXPgcvrVndIyoUBVfmpRD4B5blu89DDR3Mcis2aA3Hnt/
 Gw+ELM9sDA/PpuXFpTxpP6jhVaeAiTDAnes+8v8SXiajdYSrwfrSHzxNEm7nrbZA9URurSF
 26W3mWrO7ENChFU++48Kg==
UI-OutboundReport: notjunk:1;M01:P0:Veezp+pzH50=;fQdXUNRiEahj4vJ6rHcHaSy/1uF
 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
 Nx9vyhTyHV2PA=
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 09:57, YuanZhe Liu wrote:
> ufx_usb_probe() stores the usb_device pointer in dev->udev without
> taking a reference, and ufx_usb_disconnect() does not wait for in-flight
> control transfers.  A mode set or blank request that runs while the
> device is being unplugged - through ufx_ops_set_par() or ufx_ops_blank()
> on an open /dev/fbN file - keeps issuing synchronous control messages fo=
r
> the whole ufx_set_vid_mode() sequence, including two msleep(1) delays in
> ufx_config_pix_clk().  Once the disconnect callback returns, the USB cor=
e
> may release the usb_device, and the next ufx_reg_write()/ufx_reg_read()
> dereferences dev->udev through __create_pipe():
>=20
>    general protection fault, probably for non-canonical address
>    0xdffffc0000000006: 0000 [#1] SMP
>    KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037=
]
>    RIP: __create_pipe include/linux/usb.h:2031
>    Call Trace:
>     ufx_set_vid_mode
>     ufx_ops_set_par
>     fb_set_var
>     fb_set_var_from_user
>     store_rotate
>=20
> Take a reference to the usb_device in ufx_usb_probe() and drop it in
> ufx_free(), so dev->udev and dev->gdev stay valid until the last
> ufx_data user is gone.  The control transfers then fail with -ENODEV
> instead of dereferencing freed memory.
>=20
> Also return early from ufx_set_vid_mode() while the device is inactive,
> matching the other transmit paths.  That check alone is not enough,
> because it is not serialized against ufx_usb_disconnect() and the
> transfer sequence continues after it; it only avoids a long series of
> failing transfers.
>=20
> Fixes: 3c8a63e22a08 ("Add support for SMSC UFX6000/7000 USB display adap=
ters")
> Cc: stable@vger.kernel.org
> ---
> Changes in v2:
>   - Hold a reference to the usb_device and drop it in ufx_free() so
>     dev->udev stays valid for the whole transfer sequence; the
>     usb_active check alone only covers the entry (review feedback).
>   drivers/video/fbdev/smscufx.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
applied.

Thanks!
Helge

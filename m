Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F349C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7C4510F62D;
	Fri, 11 Sep 2026 14:44:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="f7ZiCOfP";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB12B10F62D
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 14:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1789137834; x=1789742634; i=markus.elfring@web.de;
 bh=I/lYyq4Pgvywr3fTVgo7T85DV0FEJvz+1sksf8sBs4w=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=f7ZiCOfP6mYdZ8z6JaX+RG1WAVXc2zWGn0E59SfDGzf11WaYRXfDKS6lT5jCgxs3
 4AAqRrkkbudNCW/KndXZio14Bpa0J7qDYDSzqp6fxC16TDEweN+jiPVNo+M/xDIqP
 Od2U7bTnhNMLQtSH5Mp+QlG2IsdETjx+5K8bCjHQ2YRPx3pbVZjtqchocPSSaTqrY
 Sr201Qz2LZhochQQwwo6K0LN7BPgRU4ea90a4yLmsei8K5Qj78jfY3ZvLDqQd9hkg
 Mrl9MC3+jjPxKJa6Nj+GmfmWkjZP+3DFI0Cx+weBb8C9K/ytjCPpQ0SjaU3k2S+79
 Td73d22gkx6UkEHkvg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQPdl-1xRMap0PvV-00Spob; Fri, 11
 Sep 2026 16:43:54 +0200
Message-ID: <d3cb37a3-7e79-47bd-a27c-3afe76c05b03@web.de>
Date: Fri, 11 Sep 2026 16:43:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Melissa Wen <mwen@igalia.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: sashiko-bot@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
References: <20260826-drm_pending_vblank_event_leak-v4-1-f8de8b996b9d@igalia.com>
Subject: Re: [PATCH v4] drm: Fix drm_pending_vblank_event leak in error path
 for out_fence_ptr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260826-drm_pending_vblank_event_leak-v4-1-f8de8b996b9d@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cUvS1RIXtJOQPYgpZZ8q3J7wQ47PVm+YglRvgSJsvPpXn7sNkw6
 A8PqgdMC4xkDV2zDi7zjE5DeVuzEE0NkOU3AS2nJ08sSPNwUMzjey0Gy7OLCAXDTbVRxPY9
 jlTChtbuBTxbfJRJ5v9wPaoFy3GYHw5AIb7nigvbxOYCy4nUf4ETdnjfRBcFr9zxMLPS9SO
 ZHIHzoFDN9DlxWtDxetXQ==
UI-OutboundReport: notjunk:1;M01:P0:ugL/aFZUO6c=;FQpAE6LYPdxw3bgaK5jcNRHx0LC
 tYB+YUxasoPUcrbYuFfib9CkEwMJNhvkVuQvaINnvVaY+iKyDhgYu0YXXiRPLSUYtLKK+/pPl
 MBt3b7As+/aOR75/DOLtgImwW2bw3qR2Xoik33o+JFU6hWrZzZMMMdva7sacdOTFS2pdi/CgA
 MZz1dQp1LUcD2R4t5dTP6yk3KcdYNDbwOTkE/jfSyA3c7ia7C4aPnNyBLYyGkSE24DEAVCZ4y
 YQUuur9MOJ9hv40idPWsUThZt060qOPb8wzcfBYkmREkgobk29oxWgYTyN42E8ZSe6br90rOk
 FtUBubs4ZsXyd3C4VA9D2YDiacztQTvUK/W4ovP4IGlbXQbOKtPuLWZtUmlQhQYqwiAHCabpY
 dKPg94Jg2r9+tXJeuXSq3WD1fkeodS1htG4auKKeJ/a+0q8r5wrASFUy+q1aCPwW5dIryg7Dt
 2RF86RbVYC3PUkYwOCMLd+SSeZt8GSrHk0NOzcEmeIDK0dh5DvLXzkkBgiRmxmia8HufD4npi
 iDHl/qIAKtjsLPSYW3oeyJlqYhxBbec7D6f8QgmdGdptOjmlEyboqG6gsPPIy8WZNTNQAD1SK
 YI7RkAGfD6U+xCKEhaoBrnQ1wiCdGtheCqnEK9lqvtjbWPuHBZH368PPrrw5m+g7zLH7spkGH
 sg/VaW7266cYsLvX1+RrZAHfjzGqdq+T5lCiQ+1kGIG5G3hB1/ndD/ge9yVmt/lRRwRz4EXhE
 /yEV0BOK6Q7Xd0C5+yJuKEVm1zKcZxQ1lHp0ICx+ZTc/RkrId4LcpN3cbnHW8541wQqXocRrn
 sgC9se3V62RPsCdmB97Bw1M9+dk4INnoONdhKE0u/wK7MsSPxNqP88BGbIo6bDsBQn2Kym3ls
 OGr7GjVEBIKym9MSCaMer35u1HGsumEUvnuFvEGjIKoJ/TWWZb7UDHydd4C0mOQmj1i7c9BlA
 DF+muXtj3KayNyO34fAXfPLtYAW6hX3Xbg8eZ7qIF75+oTJmKAVUyv457zT/gRta9mbOmeVqq
 7HDP4IFAWEfXGvzAMCzPUg1+GzYnNVJKiOJbuBYTI9RN3CGRUWMLRCMuyUUGIIn1XNVA+84ps
 fOi9Owt65LKfAKGWZ9uPeRkpOSrfa+Fdy7NxhHRZ/ayyjsCG+essebreAbtMT38Cf2EWobmbf
 vM+zULqr4vNZqjgl4UGD0KZ5fbksYJAdZ8PqZqtXOyA0ZG1UsnGpgA9OKTz0TOfQbJJjH90I9
 SQI+tQAPkiQy4UiCbmqz8BdR2lx83pUzEt1g+4pRtaz7SRSh/IbZRivT/ZBaC6+ilfp6Ylvkh
 b7JrtcmDTBuJUi9hc9cTJh6T6tsDYix8kHP149LKsQeF9dNKNohYXj7vul/628kSbhXk1hGtx
 WW2b6U6YJRnA6GBHBmv9lqsPucZr/+dbdc5TUWG1aOvBlKHNptxNYKOWh+RFKl7xG6H6hj6Je
 ilhw8ThZZdZwZSq/HOAQU1COXo3REBwKQF1tDI+JB80DaL26onGFtnl40vVQaui2voC+pCBrU
 ec9tx63qVIvInYn0WWbz04nrHXoqkP/7Nl5JRkcx5fn0BKLpbgpTtK72/ECVWI22GfKRAdrMe
 CHeP/Wqa2Zy2OPvvUQMexgX5h+pvR0TNV3QjsqA4i/pceL9vAbbPrUXLozWdVNR0J6samuVEY
 1xzS0cWFj7itnpVD2kdOmHNGVJvZq7kXB2/6ZF2kNs1YAVlFk8Edupp78i7u21zIPhgZLVBut
 Fg/aeOPNurDIxskmJduMURueDLL4/luFcZi4OusKN+fj92XihXa+TyAVJ3tLfXu9L+W9lCkcK
 KqLGAlsunPx3yGEVYfkXt6stuWKG7GJGtHF7HWc51smHDUd1yL0Ki1FLn7hUPCt8Axh3SRy7s
 SA0CpR1LOhmiJ2PRSRVd+qtU82QkctViwjmUYqwLc6RT2mzDtkugcxAzLmamWs30URO23AfKe
 MuYo5aQir5/zwGtyWFbzCirvmc4T+f23dyKea26zyaU+RLkxdZey1vWyeA2aeOZcx0PNnKOBl
 661WMLIaLlWcqnwlJ3j9Rkrcf4rEpRf6Gr2OB+pTT2CsjJ1DhXx4/3ACKJROJKn4/i3sh+CNB
 eowvE5G3OE6QgDyLkPL/xeas/mrOsf6DGYp9c6o9PV2nRv1T4LLA8TpEWQPbgnOVnq7uz1h30
 Fj4ddVQ+o5ddLizc3jWhXGE6ltCJCnfgKtoBiyhejT88rwhdcWp890p/eqxupOLY6aGjGdpfm
 b0wWay147qTSyvRviDktALqWy2qwEHZj9sXLFd9Ry/y2JoY79nafEKVl+iVj3kcan3oXqQpr9
 kQbkxH3VNtblaXKqbxtWVYh5vsBJMVXH6q83/tdErEtb0cuTGkKwvzaQ0A0+rtZpjZJVNmKK/
 y4437QhRvpWtthLzFcjbmRk+z8iWBNYyH1amVUcYx3G4zpGPoe1l0lumk0NPva73qcRNYFBYQ
 uIku0hzWxSFT7R4tR7FqtnWeyO1kQUVCzR4Xg1KzylJ13cndcPgwMZWvSmcEm4bwAvnbg3C3A
 iM01mNp5WFjsZciOSpK2daW8C0F2B4ojA8qVxkb62jIWWHNTaek+DAsWnU7L2Um0CfIgGzdxz
 jhxmdw1iEi0fpBaU6U3r/pO1t3FWuadtuuCxf4Nvy2fTnWq8jUt5oVlFzL/Eu9fSwmq8ZOwn8
 69Hu0yJDybsn+U3NTsV0lLrlScMefNAadxPH1xMLrRxXkjdgMQI5ffJmIr9U47ZTiEpLyXXHc
 AFg3wLk7NGyq1syyv/4gUcFksGuPbnn2X0bNV4ru9QexGd8KrWgUAzR1bJHp9PXXScimCWuRe
 +THXkViYc2rwU0gA3Gh+RPLFwMcqbDhQaPFw5Zv+xjNORlX7Gkn7J2fdmcwT219jHvIV76pjM
 KJDN9KGH/vtDazB5tkIHP371JsOLItxilfT8brmzR7BaUA2ahnx9am+ZVRzY6dSNLL0vNCqWE
 MXabp4c1lXQvz2G/RrOFEKpBsj0r83gvyKa6PzWnjygNlQ5T/PREUpB+XRSeJNSdFKv0U3ce3
 ARQq2CwagT+ijyJySMF+ou3GJo2J82yO2/dN17uQMOjkAa3IYAPJi7qgU+RNrpTAr6JRSz+eR
 rvMx0aRWINfUmfK+4llWN8loMHFBL2V79qm1fC27x2jET/X428KggRqgV6ebSWNI8pOo/trDz
 IjMQJCIgNQIFCRoO44kIxir1pz+Z22nbS5T2bBP86veTksSr28vPLNC+6hv/AQ0h3hQIdjiML
 WjMKDnGPpe7qIwZ6tHTkBIslkrV7cnI+B1ZsWV7cI5G6llWub5AJvEOWWPKd7UmI/4ktt13pv
 jKArBKlT858Gl34JgifhtNjNYQp0chwdksMXoc8HB7eRvEKSCtxSUM+Wcz7mMBjheygRl1PQA
 BxEJVHZI+qNZSxq81YHKvD4Y5gELNQppwUo/lTA2p8/U+rlTxDuLA0BiaTdTfWv57xm62RRQe
 e5N77LBth8SyIiR4HAlZ5jDMoUvnnzanvqbUTa9jEsQhrs3I12wjkMsD4qzRHzreiZfckZvmP
 eLDiXN4bi2Zn+fuqgOLsdT2llSTLJOZ2UNqWfsdVthEEFGcD/NgTfHqVSDh2rezHLcEKy5j3n
 Vf/OG4LE0GnvI219Y8VyCGwOBbrcQBD/nVKLFbHV+ncmtXqQyDTw/oyQdVnWTi+dWJ/H9VuPF
 jzLp3LISzGQ+D3gXQPhFV5uC7RgNBWmX8ZWXK7ECEq74tzU0RiPpEbi5vso4VHcy2rVRJFwxB
 3IdM227fNsBTP3oLDCRS7r5c4u4BrfZW8Wn87Jp+4A1qBew6ueLHissVQ5Ulm3LW1UGAImDQH
 kK9t1KTP/An4CSmoOmTZ4g3XvTrqG05/Em0lenZhgPehghJTMUeZ7Wl6F4aMC1N2ooNlBFonN
 MHtKkoKS0xvWdUAoOmXfYI50RUXD+fw867kdrpYHMuVpFAhmFJFiG14q97n8TPA86y49ZV6Ls
 Xp1Fae1YqNQUoww+clayLP+bCVXlEGtrUQfDtcezf3BfWUWfqxEsCuiiyCAvrCOaUIrBjt/AJ
 UPZrQgIOI4nnlWD+XHdnuLp88T+sYgnZbYOfwnrfB4gPZdLCzTITfNu2/OnauIvXJODgS5WC+
 qarOKKIR6avU9pczWE5pU6gsZ3kVqgPyvWGiRw2uonL/vENIKiJcy/5chEViia1jsf2ltPsOL
 SbU1EF4RAkSEmJg3N7qeKAykcJWa8fEMDTy7CTa3lsZR2Ec7sSZ/lt2NcOYmxGsA1FFK6V2qk
 LYuWz70QGG0NgbMbSRYuJcAX40Ao/6989PpWZ+9i+bdxpbnjK05JDJH40fRYusTzr3J6V8H7i
 g8z9SMGTV1iEPDB18GXhnxeY7LNP8IoV9Px+EYvk0UbHU40nSBmAR/gT8irjmB6cPtmzvsIZc
 vfZqJxY8cbIag4FQZNfQ4n13mMGB3JBDcqigcg0ZThGRyqbHVclHC/rBIzz2ZfXYC9lFnZIZj
 Ik9DhqJBw2Q0ltP6qYfzfcaATV4tXPcm6n43NydEwbwE0C9T19SJTUsiGAQJ72bqIYEdsKz6n
 X2JrHcDzjr9mVvHfBlLlcUTlp/7Uv8K/em+9C2focLGXjjlkGkI/6f8MDcS2qyB5EDB3u3OEQ
 XWZG3LtsMfOTJtlFbQYgW8EQsVf1EsBm2hIMJ5cTbV5YvQBsyleq//plTCGeSMKxdT2zVDmXC
 k+a7fjkJuBoOBEUsxVt3MWwQUWs86SzoXTOw4MwOCQJZPpCjlfGVJWWvOQTM6EpiKHfaqakuS
 VaboUSfIQuQuvomMmc/Ek/U6nwzfVAyxc5bq6qha2fSmoG2L9MW9yo9EPcGSDY80bAq0UxHUZ
 7ubs49gEUaWxer3yVWkYVoavuVhGKl0S5+CsU2Nf5F67W0obImfiwb5/7aShTBbQkyfr5kM6X
 HkIG2N0m5Yqm+eBAku9NYpJy+fyiz0BgTu4nErzjZko9fxdRaVIugzYwAtrL8xpeGFYvquzhB
 9CZMvJHqo07GETW0ImolU14M9HEzOrsqxpRE09NHIAzLK51MaROVhzD/HlvWc62DkROjKw7tv
 ExzxZsmcUnvdfKS4pKaVqsBY+7LV0sgevUG6TfXRj8eRwcU/ZJgTfViR1wMhLyy3/xVm9+Jph
 /Zy/t9yAl1+eIBaBI+jvPRnVf1aGIkCZHC1JFVJvLZXZzlN88FnT1W6jlfQDtZmghy7OkFLVE
 TQo0xBg5zb9sJNYhHx+6Kq5SAMMncDTNHtgJH9b/OlVkScB8GjayfdKvPK3VQfxtqOS7hzYPS
 qnePbMRzxcNlqvP+zGGVdzuqwNU4T9g9iPCaC+J/PuZssz0Q0L8xySdjNkXeNZt1iGnyCb2RM
 2GutBxHMdXH6WNg4OKxS6Q6jYNfJgOteEJDLY5vcEBk/WmYd/K8tn/x9iJCZbXC1Pnr6k1mcm
 YDgrehTE/6meBR2Dlr3hPhQk7ZRR5T9tsGq+LEA23DxkAuU742aArTBBRlRcxL5pSr8DAYNs7
 0TGb+RR/0H5BJEslerG1J1IzmmV3x7c0VG3Tl6hbOIat043Zogo5HjjW0DcaybOWsyGFxCxp/
 XPXKmpQoyvMumnLsSbHJ9jY0juviLU3ybFN25mOkTPUkEWBgPBmp3Lt3y2iGPCneh3CCTuBzW
 o/uUoxfeHTn3X6NdsAEYV5RqO/KsJBuOqipGcyX0xRmXTNq0Var5NlQ6A9wZsYpf4a6U81X0y
 e6j715fr7Hvj7l2uf87PM/63In+qXvH20CGFPQknbDAd6gmEsUQx/Iv0N6Lr/ccltUFKhmJLE
 +Qm5CMpcJNsl/nciiQeCNQGMMKde+6EoCdBS0Gvicrff6HOe23Pl5ky1s9eerDCbKpkMJ8v17
 2Q4/FuTHlZsCp7h/GuOCjBZRYGthAMicqkbvoBqKLNvnOTvEQy3f3dqe6txD3E7rTFHrQWqPK
 UNNfddaIJAUSM5THjbo07Lie46uhE/MkQtEVUh24DI6NwdsJKcmKPUY6ByLawOeszhIoxn0O3
 1XnPmV6ete5kK2/wIVC5f/F1LG4oGn1RlX+Rt4SZUwuehrW2hRy+WNYlRDDGZZS4KFaB6AGZn
 wTBh7mK9h2uD1SeBf9d4ac2iZnSZy7BayU1H145dw43Qf8pl0bFOuumDnrPiXJtN9d1svMft+
 z9N4Ht32cQTUALwbGMV7HspNYCbGXhyEGDB5TMbW7tY1SiFUrBY7Th7eWkdHq40gV7JU/jpRl
 P4YPL1u/rMcc4MYoj3DhS0erfs1oE5uG/L574i8divKkaJlx44YMIiFRLa8qOBZPoH7la08wY
 y7tmGLVGL/75Ig7sUQQA2cRVbS6UsJCRITXbI8JPUTQPgAN2RtAA5wJK9Ty6wFb+s=
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

> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -1458,10 +1458,12 @@ static int prepare_signaling(struct drm_device *=
dev,
>  			struct dma_fence *fence;
>  			struct drm_out_fence_state *f;
> =20
> +			ret =3D -ENOMEM;
> +

How do you think about to refine the source code a bit more?

I imagine that this assignment statement can be moved behind an additional=
 label
like e_nomem.


>  			f =3D krealloc(*fence_state, sizeof(**fence_state) *
>  				     (*num_fences + 1), GFP_KERNEL);
>  			if (!f)
> -				return -ENOMEM;
> +				goto err_free_event;
> =20
>  			memset(&f[*num_fences], 0, sizeof(*f));
> =20


=E2=80=A6
> @@ -1531,6 +1533,11 @@ static int prepare_signaling(struct drm_device *d=
ev,
>  	}
> =20
>  	return 0;
> +
> +err_free_event:
> +	drm_event_cancel_free(dev, &crtc_state->event->base);

+err_reset_event:

Would you like to avoid a bit of duplicate source code from an other if br=
anch?
https://elixir.bootlin.com/linux/v7.3-rc1/source/drivers/gpu/drm/drm_atomi=
c_uapi.c#L1457-L1461

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv7.3-rc2#n572


> +	crtc_state->event =3D NULL;
> +	return ret;
>  }


Regards,
Markus

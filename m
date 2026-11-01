Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF04606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 23:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wbdt/b7F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 787BC10E4D1;
	Sun,  1 Nov 2026 23:15:53 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4CFF10E4D1
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:15:46 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa36fc0eso11277a12.0
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 15:15:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793574945; cv=none;
 d=google.com; s=arc-20260327;
 b=HGYU3gqttBypGpyG6Zc4S9Efb1Pb4f6FLcEzZX3expWtiGEE58zVSmCrGrCdYfQFBp
 1IZCHay+jy4gAprtkzWr78faE5IE8Vj8A0hglq1IZWEnlAl75SaJTUtMpXhquftZZsws
 X8aMiVSqJV16Wyt37UGPks4NBmYYQJCatsGtSdYUWqB33j9euh+6BIs/m3qFhILJK0+E
 /2W995d8N+lg7rlhxPOJQ47njhAvmbF6s2X1Mmv1x7StM/F6dW4/M6d8U9mVCaZnpbUo
 6urdjkgbUekl4uuGb8jFvBSVYQBgWHzoFfnOhbgz7MArWlbEbWVNUtPvTR61el4PzHhv
 I7DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=b85SCZUlEMSxM24RW75vmTYnk/54bnSaR4ktiJzCCEI=;
 fh=41lnHuyGq0T9KLPB71cFOTQ6NUW9p+wjdrWs1L/tmzw=;
 b=SN9z6amq3gt3V4qnBFr0lmyVVvM28mQX5p0EAx+bg20S2jcAOcV3zuHl5ZXEPuLsu7
 G6IV6cSJ9ucxz7Nwu4bUne+MBWrHGIZVma/XrRq4d6imk8ggDK5UmZA386X03EY1PB+s
 q93d/hHKvdMqCW79S4O7nLHjr6kMQC0oZwP2nGr8QqQouJ+iYAdqbLE/Au0lmaSZ6GNK
 z0igNi+B4O62EoY8zMD6Vz8ij8CYfaPETB8pSlJS/gBZHpW7UIq7el1bXS0s55SggP3t
 ovf6//xXiZVgVU8nt09PLf7DSC/B3ZAOdoA9ucyjztkHGz22YlG9BMYhNybEXD9HKYMm
 3MBw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793574945; x=1794179745;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=b85SCZUlEMSxM24RW75vmTYnk/54bnSaR4ktiJzCCEI=;
 b=Wbdt/b7FOSIb8iFGJHvWr6a21ma69TtCHfmfdrMnG2sebSA5kT5iS3Zgewcb6MWP0O
 /OCd83WFOwZUia9XQG+EyObP+IeqcYOkNQajROQbhBbow7bV6zgOSrZD904j4S1m25jg
 6XWzJAuP7l64uYO1WxGHy5s28+MI66Ec+cOipC3jO27oOGi7dZITe17zllKuM0HbAQzC
 U9Zv3cNfJQeNy0h/7C4QbM2hXGZnEqospx1NNoicU6+emlLamrn/CDQWy8XDNTxgmHaW
 2T0B0/exb3HB16ymBOqerKiSryH+zuZc4WAB1Ol3jiyA2mCCqgZS8JVc4EimqLDpWBUP
 oB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793574945; x=1794179745;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b85SCZUlEMSxM24RW75vmTYnk/54bnSaR4ktiJzCCEI=;
 b=HE3X2Z4r2QpMCXok2usO0hrMeAvYQeDZdWrNdeQ6NFguwMbzpeIpBiShBnxXfw9VAb
 bhIxj3hGzvdY6AugNVfRfxbTfsYkhL44MceGlmhqWHpuzXjPYobV4c2vprLLcN3512CL
 Uft/7eDRkNPD8qYfpKPsgt+B5rb9McckDEDcVrS/OsqgGikXkelu3z/swUY7dtJ7t6+o
 ppvujyVFQiyfmUUrw9Sn8jbZN9sbiFBxIjLVbecJD0Dlg8/0JIUTrxYYvGNCVxVM7h1e
 2YLaQBa2aW0qYLxx21UWpUSS7TxVYTLft2JN9nnv1MmvSEkp1U7NSIPytbxKH0Ar+PQF
 vG4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzM1dJTlXUV1INBUkyFww3Fe50wOtLXjquKEiSe763QS7H7DntY1xijvOznmMiTNXKzq6UjXxiz1Qk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+qnJnBGqeG8fN7UkDUFRQ5tBYujhh9RMHRZn4EaQe6Yp9gSOzO
 eRUZ95hP022y21wisATercET88kujxh+wcSID2HXhbxkQ6ZkVkOXEQ3lYEYfKLXxBXHbgjHHCzh
 elCyuIT2GSmIbIw+LuGBFKZLUlHuNZh/JOllsr6/i
X-Gm-Gg: AYBFou0X1WpW4ad2ylRijAmK9CJGEr0UIW9llv17t/ifiXXu+7iMiur6kksBBQqSnDE
 BHn+0EZNBBDopG6/x1KZWWm19X7t7nEy8ksODCA67lMAwEZRFufd7BZHZR7zqFYswXKtNstKA0y
 HUtIl+J23hpChNqoMPYUVATOjTRsyyVY30EIzK7zZChl5jux2tK2To5YI8GYpcDoTRD5Z60YCca
 IIVXH/h9467leymV2cebkYqvq7DIVLCrSg/pucrhgNVoKV+k4fLi62M8SXqZTv6g0ORqBPzZv4S
 Ix+6+s1y9giWWAm6O4p1J9HaWre/C5J0phrXGyoAD2Qg4IzWk3bxryqzDQemh9GBBQr9G/0owtn
 XNjq9kKVKSVwggCOZAwI6Bgw1yv0fRi+FzLPNLrg=
X-Received: by 2002:a05:6402:1a58:b0:6b4:880b:1b61 with SMTP id
 4fb4d7f45d1cf-6b4b3cd2861mr242904a12.12.1793574944562; Sun, 01 Nov 2026
 15:15:44 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030083539.777877-3-almasrymina@google.com>
 <179357408360.3131.16098294926514442303@kernel.org>
In-Reply-To: <179357408360.3131.16098294926514442303@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 1 Nov 2026 15:15:31 -0800
X-Gm-Features: AclHuK-UFMQ382VldDl9mQXawkR9RuLEX9lDNBBCTFPZuNPb5GUS05WDrMHtxpk
Message-ID: <CAHS8izO=-DZzaeFbczj=c5yGszo6parXeQNqqGV8oieZbmMW=w@mail.gmail.com>
Subject: Re: [PATCH net v5 2/4] net: devmem: detach TX bindings on
 NETDEV_UNREGISTER
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, pabeni@redhat.com, sdf@fomichev.me, 
 kaiyuanz@google.com, kuba@kernel.org, bobbyeshleman@meta.com, 
 asml.silence@gmail.com, dw@davidwei.uk, ap420073@gmail.com, 
 davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, shuah@kernel.org, 
 sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org, 
 andrew+netdev@lunn.ch, sdf.kernel@gmail.com, hawk@kernel.org, 
 ilias.apalodimas@linaro.org, daniel@iogearbox.net, razor@blackwall.org, 
 tariqt@nvidia.com, kaifengw@google.com, dtatulea@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 1, 2026 at 3:01=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] This patch's TX detach is incomplete.

I know about the issues with leased devices. That needs a bit of a
rework, which I have done locally, and would like to send out as a
follow up fix so I don't hold back this series.

--=20
Thanks,
Mina

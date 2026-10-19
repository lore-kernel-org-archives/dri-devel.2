Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E63D606EFE6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ERTKFlGa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B67710EF24;
	Mon, 19 Oct 2026 16:11:18 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C771E10EEBB
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:11:11 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6ae14cdc63aso16980a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:11:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792426270; cv=none;
 d=google.com; s=arc-20260327;
 b=A1pvsMoHsXXJLfsynSh/QS5GlaSylPgiT2OiA8epOe9eTL20b406VbXtXxSofxt6Ga
 KID8kFARtASHQkR7rY9X3tX5M4vudrJcIIHHT635jwcD/EP6fwZTBK5loeamzXOrXTta
 MeUm2RgNrmIW1ryohBsa7jUE8g1qxyi3H9i8w9D7G7yVG/G5eLMu+5y9MYQrzLry4NNI
 nBw1zuFiApjVzQeBux+ifyUXiQbr/irz3UIsoQ6HeSHCU7DPuVqFslBN4ojDk3yVQLZ9
 flW2J9F4oiHJehVCPS+V9NhkBprbcRkO7VAxohXdGR23BhyLWRhND+KZtkjCO0+Syr+m
 Hq7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Pr7BJMuifE78YwYx6pJZlEAPKb8dBOcE7CtzncpVA88=;
 fh=MvcEBWKzzPZcZSgco/7hu8MPMVwITefPcqzm0SEQiyM=;
 b=RFn5SSmSzE5FhyXp7HQRiShZU4niBbnqq8w6/NO1g1yJ7PUlxPYud+2gP9wN1SJpHM
 FRubeeayDsx0l90IWB0pGb0kW/ElbyM+hgGMaFCGLcwIuY2rP6aTD7H+6KIypYi/qIcd
 vyyH9ItugY9qFv7jSuXFe2TdN1WjyV7Zv+11ohbz5gi+ZBu5cVIbTrHRI9LTzmKnaBzC
 k64EzR0aXM71WSjRQwKwEeNGVH7JYyVG3eoiER+WnZrMqmrMGFEN78pYkPDmr5OBhER8
 XidN180hLCDVNuJAK0eNYxOP0sBOwtDSmAaakq6TFXm6TD482+woT2qnQa+ZdFgTBZv2
 dlaQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792426270; x=1793031070;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pr7BJMuifE78YwYx6pJZlEAPKb8dBOcE7CtzncpVA88=;
 b=ERTKFlGa8/yEm0nPrLKTZlnjukDLd676cSAR9OQU2N8MwqISGfIGjd/F+X3gPkmEww
 iYi3M65DRQTGeF5gLHMUSq8oYHmZmmaT4YfWL9r06Bo6+jAHkIT9oz2GAP7ZOkOgMU7F
 VTrDX7oEDvy733hUwripCidBqoW0n2m4CgC2ZACDHjccCw35z3kI90+gZgm88c/aI9ki
 AAwSFD307fk1Os2hwKA9bYc0DwThM0iIA42N/DTUoMALE/VPu2gZZzNGebWCMihfvWUn
 jBem9tR47KH9fhmKdMtG9QViFrfNM7Q0C/f85bCaXBqnPBzQPkJPq6JUwlKp2xvzetnb
 uE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792426270; x=1793031070;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pr7BJMuifE78YwYx6pJZlEAPKb8dBOcE7CtzncpVA88=;
 b=gGXds6GsrM0Q2h9RCl5krB+t8d1fuHmAoGUmMIWJECKF8/3zKxAL3cwokdFsohzw2e
 Zhs5EynLXlot3OfD6Nu3HOi5qfjsv7PKCl48soaDHmhcCACWcjh4w4Mnt9cbG2G7r1nI
 SzIIQP1SOHsehVXZP7xLt20W5O/QDM8vb2zeQ0Z53zJGZKoTr0YKmWcodGXhq/EcBygn
 qBeNxViHRNP8nH8cSKGipdxzBg+/TxG1Lli63U6Xi+zY/JYo86eD3LWzNotpJB+i8Apa
 EnCamh4M4vxRHHqseS4S4/kIEMcvkoOP4rgVn7Pngh8NWcPLUx4EMFJP8KSq3S0vAcFH
 qutA==
X-Forwarded-Encrypted: i=1;
 AKwUvBydvb/oLvhSNdUCLgNM93Dt1mOlVMa9XegSxJzqDSxqdhTIUkamm208mfR6nFVSoMDHICcBhEsG9j8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK7AivzR8XeuM8tpgoQ3C6yH0Ih/Dke/+gQE+E2jV53QyiW8FlN
 0m32oWfYDjkLaAkBnHOCuzUVimZHWOCLgNw1dpXDK6qS9twzqys6Y2mk//7lzvYEfp7VpKLVc83
 k8z2tLFUY9TQSzbLBJ++dTdSf1tevx0Uje7NczOan
X-Gm-Gg: AYBFou3H1FXKdkpt7DoDkWaJJxdu098VBXrWDnQxO/Zk4VUCyTTf3hNpowDhX4yp8l9
 eFt6g6/a0UmpOrjJxQbZlmXycNG1k3pTHp2/8T4U9mSeDpazBdAW8SdBeKlRRoDJk2dmbQe5il0
 7aJw5O4KKqXvvr1yuVGVcncq1LCEa+PvyNt5gCcNN2Fv9ickItRd82SpTf3I3X/epWJahpCRXKM
 FZB9HR9ziAIntyWAXcAUEdW0IVSe/nT2eZQbRxPHM9h9Ub1icmf7YxehWdQEkOq4EtajDK8Z54J
 MQTH6t/PL69gN8lyaZF9KlFt9ggxaUJ1wd3NdXAxctZAxTz1yVWlBfbV9cctN2fi1cX+G8IBR4X
 c6Js19CXTfQ==
X-Received: by 2002:aa7:d3c1:0:b0:6ae:188e:e119 with SMTP id
 4fb4d7f45d1cf-6b3ad90b655mr92225a12.9.1792426269498; Mon, 19 Oct 2026
 09:11:09 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015163915.1166043-4-almasrymina@google.com>
 <179233927086.3135.6123492094489915156@kernel.org>
In-Reply-To: <179233927086.3135.6123492094489915156@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 19 Oct 2026 09:10:57 -0700
X-Gm-Features: AclHuK8eiPagoVp9rRWfufPEyCEaXmjBdb7vS7t1VxUSJn80p85wHIDPJ3eEP2Y
Message-ID: <CAHS8izPobFzob0pF2cLqL+nqtJVL-TC50QuDHOem9_cwJoGSxA@mail.gmail.com>
Subject: Re: [PATCH net v4 3/4] netdevsim: support devmem RX and TX bindings
To: netdev-bot+sashiko@kernel.org
Cc: kuba@kernel.org, asml.silence@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
 ap420073@gmail.com, pabeni@redhat.com, kaiyuanz@google.com, 
 bobbyeshleman@meta.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
 edumazet@kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org, 
 horms@kernel.org, shuah@kernel.org, sumit.semwal@linaro.org, 
 christian.koenig@amd.com, dtatulea@nvidia.com, razor@blackwall.org, 
 daniel@iogearbox.net, tariqt@nvidia.com, kaifengw@google.com
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
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 18, 2026 at 9:01=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 (1) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] On builds where PP_DMA_INDEX_BITS is 0, this patch leads to a
>   use-after-free of the netdevsim bus device.
>

Bro this is a pre-existing issue I think. My local sashiko also caught
this but it has to do with us not doing a get_dev or something when
PP_DMA_INDEX_BITS is 0. That's a very rare condition and unrelated to
this patch series I think.

--=20
Thanks,
Mina

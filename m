Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D36D606AB2D
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=XjECWdGp;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=euA/ihmz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A945F10E147;
	Wed, 21 Oct 2026 12:16:59 +0000 (UTC)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2091D10E147
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 12:16:48 +0000 (UTC)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 1212E1400081
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:16:46 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
 by ams-compute-02.internal (MEProxy); Wed, 21 Oct 2026 08:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1792585002;
 x=1792671402; bh=pVJ1x0k3sdze9cPiJou8MJTh07f7bzis+TTbrxn9Qu4=; b=
 XjECWdGpZYFpXdeaeMW/MsdcYGcMMFdcUkZcALqzR+6Sc+j5GaGg9fDC/380mug+
 mG67U5MkU3tg/Fr8SVKGPCsyg4JkvBM1kH7DNC9F9/rD2CcAMOJAjbq7ljQtmUKB
 aMvMsNcqAfF5SoYEdWYh76RBmA+063XOG9UqYin57K3ioYJPmU5TOaFxWDoZdCyv
 sxquUR4K65eFAqqzUzrcTFFsZHBIlxB/MuaOhGH02dN1CBwaD/0/ZFWbLFsrffFn
 DCovWWPE79O8FFBEm03CkSwOUO9KLlkChMs07gUlWfhCaCJnHO5QTeUHamMFxCMw
 HC9hscOG7cD5mw2rcCiDEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792585002; x=
 1792671402; bh=pVJ1x0k3sdze9cPiJou8MJTh07f7bzis+TTbrxn9Qu4=; b=e
 uA/ihmzzmaNc5dTva5RUUwnhwxbvd5z8wFJ/0b58t0MG08rRSf/iw6ee1NH9Zjvs
 zsoqPbFKE1ohkiJ+erNFbXbAhgUq0nm+2lOcpn2gXHDCZ6gzwkJivFCLoPJMpExa
 HcMoiQjLROKxIPHqo5RHkbSFB6OGIufSYDJMHeQhpsSpwGnjlVNRbyc72InUOfdN
 oFVa5T7aWYeGhfwchVOq3WTpmG1NQIa22mMGAdaU8ngEVyMO1Se08+E2uhxAvZNS
 VTcfhI5sYivnlKxUp8FBET//jcC8kLAPZSXA4v8O2+H3H+HRZQM2/W4lJn7r6clk
 owebCSOOreOCvMQ8gjSAA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792585002; d=arndb.de; mf=PGFybmRAYXJuZGIuZGU+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm1:rsa-sha256:KnGSiBrmAiUsyopdv5ZZIu+Wuv2eL9/XUVfjgB8RaNexhv4
 1VyKaGnYZ9nTSfwRbZlUcugxzLjiu5s/HK2Qa86ElEs6lf8RjvMNT/D1scWj2rqA
 L98pnnToz4IoeMTbONTzqA3fb3ZUIevyPEXdiSTOW+q/H+XkBryYOcZneYUYvGaF
 YoLfRSyO0k8xP6MXpfJm3r0aDQeSbRaAsypnmQvBxHTxi4Y7nQxpYXQh0XNDHgKD
 sWFAFd5YIFQ7Uwah4+zyRhqp2w2OPNdkge1tGJVo+jdWipBnxMK2C7VtRgd1W6PA
 g8E2FHgdyDC6KEFQ34e+PJjPEZ7Epdyvf0z+HVw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:sXYK5kqg5RAIxlV5JP7bTAEctlUDSe2I6M0f0fooR4o=:k1g1N9t8QGAgjH9tZVDG6P2SW1DLJKdHamEVOCUcq/Y=;
X-ME-Sender: <xms:Ja3YarL0794Gx-VAcnXuU0QxZUHXWoz4IWKKIn5rJNRAgO78O5bKEQ>
 <xme:Ja3Yap_vqU2j4TYeDYZJUuTE54r2wxFSc1G7hRPrmf6T7YpeUCSclhvrvj9usxP2L
 fE6w21zg2udr-4u2mCO4fLaPV7GFWNtrNvgpVoWGtdJ8Tss4AqezqxI>
X-ME-Proxy-Cause: dmFkZTFQx89gykQunQ8ka8t3krFt0J9UEA73ov9mxUxaGE+V0E3JjhdBeIaJ1Af3Godnc6
 y0EGHmihZKF1SNEnzexwXUS8v1vEIPj9B5x9f9FnngGJcJLveu6gPAFk12ifuKbOgDSipN
 KqHe1hU1mMpFtFEbHOWXLySt2GJMyT2/9gBdrfNQsCBKG3+pn4H05WjNLWeOxcDDBJYYRo
 1LgJHgnr7RTZlMF0Mb2yD7HXBcTJfwjkO3qrFxCCC5aCi2v/2FZ+Kr6jEzTMcPelG1Po/F
 BQapZHiFmINAZy/LvPVniBk+ipUbiLLaXjnwPhg/Et0bjc4CWqHSISyTmzEKQP5TpM3Mdr
 UEqkAMOcf+I5EjSOWCWzdU4GDc9LUIfZjAipYVByDM2QCchAxyZod5wvbRyBuGFmy/XwTe
 uCKFK9sVE7Rk+3oBDz07xU0T3phceBjRddagYEuMagrfvhr5OmSu/xFRi1TAtP3HIHqYnr
 nl5Mxpn/9BZ1jEkNuS/u08O45tEriS+WcUm3AkfmxsdIPMge1UgWrPMk7/6MyOQGUezhu+
 dIzLOiB/5vwx1GUeuUVFELe6WlbmlvCaoCwxT2RfLJ2yFuJWucZjw139KnlNtyZyPpYUhH
 2sOwJ8Eaos4Pfys1onWfXjCKGGORW9OqsMD/6y3vxlOjGfrztXFuWUIKQVjw
X-ME-Proxy: <xmx:J63YauEjnUtZW8eE0a_vG5IZU4WzOpaHcm6RZWlejHa8-3GmunyXrw>
 <xmx:J63Yaki0EML2RgNaJY7_I3_tDaU22PREUruaDEoLaQuaILNTB6rgFw>
 <xmx:J63Yarj632RdF_VW-KOy019KS7jySxesRb9_-rD7dV6yPy-nDVplpg>
 <xmx:J63YanlPXX7Eds3MSz_lwiVVBqfGDTmSTDUaVi9g0WkZAyXz5RcHIg>
 <xmx:Kq3Yagb8vSpKhOsZn7qDLlFOfIqAb03K0EEYgd440-F1GCu1zkE43cBp>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
 id 93AE632A0093; Wed, 21 Oct 2026 08:16:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: Anl2GdpqQwQR
Date: Wed, 21 Oct 2026 14:15:56 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Gary Guo" <gary@garyguo.net>, "Philipp Stanner" <phasta@kernel.org>,
 "Sumit Semwal" <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Yury Norov" <yury.norov@gmail.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <9505cbc2-7261-4f84-9769-b97e9acb1c38@app.fastmail.com>
In-Reply-To: <DMAHVQLCMQAN.3G0TBMA1UTM6H@garyguo.net>
References: <20261021095512.1345191-2-phasta@kernel.org>
 <20261021095512.1345191-3-phasta@kernel.org>
 <9f4bbc9a-fc36-4e3a-9c42-d18419c9d025@app.fastmail.com>
 <DMAHVQLCMQAN.3G0TBMA1UTM6H@garyguo.net>
Subject: Re: [PATCH 1/2] asm-generic/bitops: Add set_bit_release()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026, at 13:54, Gary Guo wrote:
> On Wed Oct 21, 2026 at 12:33 PM BST, Arnd Bergmann wrote:

>> I'm always confused by this and the new function makes it harder
>> to understand in the current form:
...
>> - Contrary to that, the kerneldoc comment over set_bit() mentions
>>   "This is a relaxed atomic operation (no implied memory barriers)"
>>   and leaves out the kcsan_mb() that is in test_and_set_bit().
>>   This makes the new set_bit_release() sound like a /stronger/
>>   version of set_bit() the same way that test_bit_acquire()
>>   is a stronger version of the (relaxed) test_bit().
>
> set_bit has relaxed semantics while test_and_set_bit implies barrier. RISC-V for
> exmaple will generate the amoor instruction for set_bit, not amoor.aqrl.

Thanks for the clarification, I did misread the implementation
and see how I was confused once more.

     Arnd

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD31606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vEPJQyAu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AED1110EB05;
	Tue, 17 Nov 2026 08:07:19 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7484C10E1B1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 18:58:51 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-380b40312e2so1502171eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:58:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794855531; cv=none;
 d=google.com; s=arc-20260327;
 b=oVcwE6UgRDvfD2gLodTQpQlvHfahEw6nCHtZUG51ZATS+QvU8WgntNM/BsuRha21GN
 lgREX3/bRIB30M73tAUS5gqGK+nOEwF5a/UfkNFtO1Ov/OGuHNgZPxu5y1u+vt/wGIdE
 BjbSfHOo9TRkQKHT7o3EKfrLjjdFiy/aPwMcynNuASG3JVIvgEZe0SJdZU9fEcNOnaZ0
 okDbphahMfoNlZ4/AVj7VvCeL4hqgKB5kt358uK0UrPil8758t+Ex0us9/AyF1wkZ6b7
 oJCzg/PhilXaKU6tf6o3/abOjDC2933bIpxH2gcWbuUn9viGnzssMeO9MNZOtF1ykLs2
 DgsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YxT/GneA83C7PNjhncVklqSfXyXr+0x0yFO6x3QnPpA=;
 fh=L8lCLO+IQxPubl2xiseFbSepb/djw3JT9I7ZCbKcMFk=;
 b=hl1JSw8PLzsBFdL0IybII4CJtvGNEGF5XGPiEIpRL4zys4EDWlr/9C526bU+IBJ6kq
 o3n7WQ8FgjE3uHQnwdvPCY9/+jvmLI8e2pUOrAIq6+Ukv8OyyRqLAkY+4tvrHoU0LGaf
 747tn0+5vEwk6RGjAbg/zt4QU2cuCzWYfcUBhiuGe9M2XI34KIsWP+VzynFMvXKK4h+c
 qtbS+WdaSXtllr3PVO+MsTMbsw9D9hOD98bnLVPnTe08QVoIzxY2vHKROz92kf6xOhcq
 IxpVRsBv7Ek7cz569pLFc79ECZ1+jF5oqrt8UlkyX7obiFpxpAz+bbsTFrtr4St6UBOD
 oDiA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794855531; x=1795460331; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YxT/GneA83C7PNjhncVklqSfXyXr+0x0yFO6x3QnPpA=;
 b=vEPJQyAuJt9CmHcgzRXXoOXlzsT54o7XnuUHqRmJRIABaAgqaGAcBJyTvwMvV1oYEm
 sehhRrPsL5f5xgbrvt5WAab2tDPl3eo5kEdK+RMddl6vzzVV1eMGYp9kDXYonvFW3IUM
 /G2y2icWuRE48zdzuH+0KE1otme71Rb8/70e2fcppO9TQDcuHgQ1LNBJyBt3psXiIy0s
 JDm8DgDf1kg+XIC/9uORyS8tfd3XxBNdeu0pt0VRLsF95X6C3AuNEDbtoaQVNpvdYS1m
 G2T+cHneZY7Xr1DkNJzE8nhnm+8RLmu/rbWJ5cBA0AA2MQNftg+br/K8itqZA34KoIBF
 7f9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794855531; x=1795460331;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YxT/GneA83C7PNjhncVklqSfXyXr+0x0yFO6x3QnPpA=;
 b=zLJncngfHnfD8aaP8kjJAstbAl/51iE4UbG5nk2hSOA2+DsO1R5M1mteKJK+kTD8Dl
 EXMFZDBa06s4gC9S7tXAr/3bm3nWGUjzhnS2SI/u6iA0DzEhmBnLoVsOx0c34tyls5VE
 FYShAd/JHfnbgG1zt9ltTtY1nUA2Ab1fUBbVz/PUvIiVORHbBIGgydvG1zCpiOnYIjs0
 YUxkBVbnXCe0liwz9CTqFFUau84HiFc9XuzTs/iIHWN9jzWxemI3faXObYnQed7q4h2s
 vPoCWKXUh/MRTVRzZWoVVt+xTXEy0hm4VmGsbjIPoCJs/gJAIHl3nuSQRPY88cVX3rIq
 QlMQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEPi3lyzF1SPuoKvh8I/xowo/ZbS2JSLKZ4MTGFmxJ6Js/uYPlTKgEVJy45sGpFAkU6O8Ux74RbX8o=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+vAl5saz+l1PqZRZbsRZ7iZR2NXZSPv9qcRLb4ofbHbXPpIbcF
 La2AVTxn7fKef9t+3He0qz0RWzmcNIQOo5r6+U4+D3ZN6hol6bBNDnajZQKJ4R8pT2pMhL3Zfy6
 YAZu3NbIy7I4oXEr4+d3ETCrPoFpeNAQ=
X-Gm-Gg: AYBFou2C5WZ3y4tM/7G2eekdNL1NS9XqKRwDcR3yYy4hJBlfX1ccb9961ovxga8SxrL
 pny0YnJIWGaKLK8CTOO17/AxTXpH2I6rkzXtYeRuKeQ1yzPEeeiS+BamKr/E+CqwM6tawEwtWRp
 lrsUYJB3Zv4UiCg0H+nYFMmaw69Y1nCYZNN51B3UQ35caYmIzvk2wnkSWZijoCLfB80fknoNwBt
 dwWu1jT4zxWQaNGHRfYUQrR3G2gdB8BRACSpI2ku8c5xRalwh0z79FUk1EkxPLQvcQBMVDMkI7m
 depEwKPpOw7w0dU0OlBZuyTWdyY6u2hO7aP+zhQ2AZXXKYRviXSGDRnKegEAjvrGEqC3tKL+ArF
 ziyVFRhgGtEUkCckBJw1c9yU2cEu7W2IivTs+rpB1jghiiY4VXIA54IFis3Up5OmqVjpbdicwzr
 xNn3Di1tfdLLce5jPu6yM5CyL+EqvKgSFaJncN
X-Received: by 2002:a05:7300:d18b:b0:377:7f17:98ce with SMTP id
 5a478bee46e88-37966387710mr11557059eec.21.1794855530579; Mon, 16 Nov 2026
 10:58:50 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAMeQTsZbLYpPKySm9ubYc8pw0t62ZEdKkkzc4h3Hdjq-9pGO6A@mail.gmail.com>
 <20261113085341.61992-1-jttelaak@hotmail.com>
 <CAFGNeajPo8DrqNbM+86AQz0LT98a69_+T7R8DoKAX4Q2LJE0kw@mail.gmail.com>
 <CAFGNeage70+BaM6SP-q7YAgp-tgrATuO7m-eEoN6ERr0mC55aA@mail.gmail.com>
 <17f2783e-9157-458b-8463-f98395e391ca@suse.de>
 <CAFGNeagxEcfPuEHFt3TxKhCDoZ0HODpXwXcKpuBxKK=09FkRMw@mail.gmail.com>
 <CAFGNeaiYntE7dQ=-sgaM8gRKuZ+wQ-479ShXKW8v99YVSdHn5w@mail.gmail.com>
 <CAMeQTsazkHgYiCnSEC67useW++0WEY8E0RS1ShssWybrWCGuiw@mail.gmail.com>
 <CAFGNeajczb-2Xcjfaj82hc-hprJXRHsr8uSudO32j6S17T+YQw@mail.gmail.com>
 <CAMeQTsb-Tjzu6i8Fa4X6Ta-JdRPd6vf--eEePTzZKvPuPX5GGg@mail.gmail.com>
In-Reply-To: <CAMeQTsb-Tjzu6i8Fa4X6Ta-JdRPd6vf--eEePTzZKvPuPX5GGg@mail.gmail.com>
From: Joseph Telaak <jttelaak04@gmail.com>
Date: Mon, 16 Nov 2026 13:58:39 -0500
X-Gm-Features: AclHuK8X289CyTmApwJAL1kVwCB9RQz2sdq70fY8PpJTiopkglFERQ6zf0u19_A
Message-ID: <CAPY4CJ5=+fXRX=29uS_oxwVQxstAf4WoFNVSYaUiYmWEjar5Kw@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Gabriel Gama <operatingsystemsdepression@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 17 Nov 2026 08:07:18 +0000
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 3:26 PM Patrik Jakobsson wrote:
> On Mon, Nov 16, 2026 at 3:09 PM Gabriel Gama wrote:
> > If I'm not mistaken, Joseph removed his kernel RFCs (This is in his
> > GitHub repo)
>
> He offered to work together with you? Two drivers for the same
> hardware is a waste of time and resources for everybody. Lets keep it
> simple.

Gabriel is right, I've withdrawn my RFCs.

Alyssa Rosenzweig closed my Mesa MR [1]. Part of it was that I'd posted
an early draft that was far from ready, but the core of it was the AI
use itself: the proprietary SGX driver's source leaked widely enough
that it's likely in the models' training data, so there's no way to
show where LLM-written code for this GPU really came from. I wasn't
aware of the leak until she pointed it out.

My driver is staying out of tree. I'm leaving it up, though, since
several people are using it now, and fairly successfully.

I do agree with you that the SGX cores belong together in one driver.
powervr_sgx was built that way: a table of cores, with the SGX545
in it and an SGX530 (TI OMAP3630) on the way. Unfortunately it's not
going to happen with my driver.

> > For Poulsbo I'll stick with the GMA500 drm, it makes much more sense;
> > Once I finish reverse-engineering the SGX544MP2, I plan to develop a
> > separate DRM driver for it.
>
> Again, why don't you join Joseph on this? Mesa is not going to accept
> 3 different drivers either if the hardware is similar.

Gabriel, on the AI question you raised earlier: from what you describe
(most of reMESA generated with AI, built partly on earlier RE work that
also used AI), I think you'll have a hard time with Mesa as well,
whatever the PROVENANCE.md says. Check their rules on reverse
engineering the vendor's binaries (xpsb-glx, psb_dri.so) too, before
putting much more into the Mesa side. Here are some of the links Alyssa
gave me:

https://kusma.xyz/blog/2026/03/26/open-source-and-ai/
https://asahilinux.org/llm-policy/
https://nouveau.freedesktop.org/Humanity.html
https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/docs/drivers/panfrost.rst#ai-policy
https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/imagination/README.md#contribution-policy

[1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/46286#note_3783031

Joseph

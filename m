Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70737606BA03
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ymuneP//
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C53B010E29C;
	Mon, 16 Nov 2026 19:07:25 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D143310E323
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 19:07:19 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id
 5614622812f47-53ec92375d2so2019026b6e.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:07:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794856039; cv=none;
 d=google.com; s=arc-20260327;
 b=IIO4ntgTNMzLr8gN7BrPgPXk1x8mvPrfgNrPYavnMP/OJkZ84Qs0brt/H4LUxCnZ6c
 /da0j7YOqYdAJ7VzUqvG55Df67RdI7ZA83BNQT1K9Qx59ziWHR6RdWDzlYjTFpWD1RwI
 g9XcTtp0SWdgT0yZFNQlVjcgxLzMdudjANzjVCHfFiZCq1/9aVOzVKk1bdKzBAKkyZ7e
 Pi4BM/tPxkonwNrxHX/B8OcN68b0ra+UfBrid1UM7Q/O+X61LnGyFxLBel4A1JaZkCLM
 /9vpcUuh0CWNu2TtHK7gicsyj9UrzOF1z3IocAD0I2mtWHmrTRUg4On86ur8hYW0SNPb
 i5fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hqx2iKcYXoT0rI7XkJI7vYQgpp86Z3H/yee79lupk44=;
 fh=+s2tLCsVK9Z97Prr6NFutFUAprlO77sodRHYfA8yUFE=;
 b=SV8nZjaLYDl70rpXGbQhM+0wHn0lY0kOFJjfSuSAZReGwhSCAddos5aLEgPMtoKQfS
 TLMyPCda6k0U57MYm2nIqDpYVn9JGegM1KpEIJ3xzAx534Ag7++N2Pi7XvTICgIrNvBV
 +yKAax+qeRx/aMj/TNiF0VLo6XPYq9VIth61FZc7XQqPcbcg3nPGFepGE1mNhSY3UsSF
 ZCcml4iOH741IPBZIC/Gsc49anL57yN8hVcpDE9CyigLno574o5d4ebOaNgAhuHxAGgF
 deY2F0LJCh4+XyafH+l0+FdjLV7YivsotZ4Rhe25FuiOk+gDZb4fAaQ3Ol5DouxIKr2R
 b3lQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794856039; x=1795460839; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hqx2iKcYXoT0rI7XkJI7vYQgpp86Z3H/yee79lupk44=;
 b=ymuneP//CcIhRWqwgmYu4uRRHnsD+3C21lbjvcf4QGOLt/HtSy3AUR2krm2+VyhwDH
 +ROpx9QfHzST1d0QaCOcdym3ahCm5pnbGIopD3JdHR7LWjGtYvMX59Nviktuhrmz0nss
 qFq0GQNd20u004QDHlS0PL5R5lacJuA2QW6TMKUwV/nP6oQIwZbaRaQFqzexw/8gq5BC
 7Rw26Wl5ZJbf/TRNoR07faAbyIODyZc33ZuteDUGf7RaLD7yZjaBCV44BNbgxI+wPa7h
 6LHLV1PX5lr2jBMKjZSyMquTZ7epPyZZH2xg9cQGEWA1FlohtmcMHpoau4aXB3oHvoNM
 zkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794856039; x=1795460839;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hqx2iKcYXoT0rI7XkJI7vYQgpp86Z3H/yee79lupk44=;
 b=xYv4dNg8FsDeNuHRmbiTxp/slHL8CC9ZjjIxPNOLam1THYQVV3o+fe0LI90uDuEmCi
 zRZGuMOBy8qHUc+o0qcZU7U7Sd5cDT/7dArfEE8Wf+3iF42XipPhm9tgbTNNRqR/X2RX
 y6Bqnnm1E9mI50crSLKF1CVtkmJOAbz+GCYgGFjhr2W5YsEHnkkAo6yYCunHJ4mEEuGs
 lvygHjBil+B1zvQCEHttUEvUtmATkOqRcuAn5aWnoq/HHbTRHuAB4R5+x21mqch3Is9a
 jIKGX75bIote/esdtsvDbsGzG46S05fP7eQ/dSs9RPw5mWKkW8GVg61Cf54chZsolliF
 NZJg==
X-Forwarded-Encrypted: i=1;
 AL+hErEY8vq2ggS6hxaFXQQw2ZFODAoHtIR2stElnMpNVqTbnC/iEkvLiVUD5m9CEXfMa9ira86XzEpg0zs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/iibr+qKXlFEmsOn/DoVMazq5uIEZZxFlJismNzV4R0ccqF/vI
 xpnUPs3BSQxv6/63mLxgSO7cP9mbl18T2NkrxavTqmOAo06eFGMEK65L7e3yEPate0T2wQ4YcO4
 Rbr2dUT7b1feqEjrNA9R+fVMBgMSUSl0=
X-Gm-Gg: AYBFou3tC8lrb/NUEWWomTX0WfKUUPPflqo+4wb+VO6kiL2OAPOi6I/YcfHuLU6OzV3
 3Yw2xZ/slb8+LZYOpSQsMD9Tj2msd5GUWj9SH/XGyfU3MXOxVyIXl3gZxImFmyYq/hBPCLztIr7
 XuhMnQSZEZAG7sKst+jwKJQqOkAX4ckFeIMC7oZkd8xUF0GWW1JQrqvUS4ukcQo6A9c7iGEcN3G
 zSHusHgGjsWAHO9parQ+ZaY9oUew8hvTJX/SVGKXlTk11kzHeXtS8Y1fwL2u4wYbLrXWFItSuDL
 weCUvVr5r4jBGW6138XMpeHCPYulkS3c8gD2tnGNm4L2O8xCGb9eJwK+7c28l+yTBvGzNfeyXnR
 HJZagBo8RnBHn0pDYiOPaQagbZsCZ6x12/SM=
X-Received: by 2002:a05:6808:50a4:b0:557:30d7:f40e with SMTP id
 5614622812f47-56e6531a248mr9615653b6e.53.1794856038876; Mon, 16 Nov 2026
 11:07:18 -0800 (PST)
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
 <CAPY4CJ5=+fXRX=29uS_oxwVQxstAf4WoFNVSYaUiYmWEjar5Kw@mail.gmail.com>
In-Reply-To: <CAPY4CJ5=+fXRX=29uS_oxwVQxstAf4WoFNVSYaUiYmWEjar5Kw@mail.gmail.com>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Mon, 16 Nov 2026 20:07:06 +0100
X-Gm-Features: AclHuK-rBOHMcvVmTrbP__wioAVfpdO2uT5HdRb9CWgymRu2t2Zq44VwiiIN39c
Message-ID: <CAMeQTsab5H7F5CFvd_XkDndmMiBXRSYBhrMHAf9jynzEqaWp+w@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Joseph Telaak <jttelaak04@gmail.com>
Cc: Gabriel Gama <operatingsystemsdepression@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 7:58=E2=80=AFPM Joseph Telaak <jttelaak04@gmail.com=
> wrote:
>
> On Mon, Nov 16, 2026 at 3:26 PM Patrik Jakobsson wrote:
> > On Mon, Nov 16, 2026 at 3:09 PM Gabriel Gama wrote:
> > > If I'm not mistaken, Joseph removed his kernel RFCs (This is in his
> > > GitHub repo)
> >
> > He offered to work together with you? Two drivers for the same
> > hardware is a waste of time and resources for everybody. Lets keep it
> > simple.
>
> Gabriel is right, I've withdrawn my RFCs.
>
> Alyssa Rosenzweig closed my Mesa MR [1]. Part of it was that I'd posted
> an early draft that was far from ready, but the core of it was the AI
> use itself: the proprietary SGX driver's source leaked widely enough
> that it's likely in the models' training data, so there's no way to
> show where LLM-written code for this GPU really came from. I wasn't
> aware of the leak until she pointed it out.

Thanks for the clarification. ImgTec have released an open source
driver and documentation for later versions of their chips. Perhaps a
way forward is to ask them to release the docs for SGX5xx?

>
> My driver is staying out of tree. I'm leaving it up, though, since
> several people are using it now, and fairly successfully.
>
> I do agree with you that the SGX cores belong together in one driver.
> powervr_sgx was built that way: a table of cores, with the SGX545
> in it and an SGX530 (TI OMAP3630) on the way. Unfortunately it's not
> going to happen with my driver.
>
> > > For Poulsbo I'll stick with the GMA500 drm, it makes much more sense;
> > > Once I finish reverse-engineering the SGX544MP2, I plan to develop a
> > > separate DRM driver for it.
> >
> > Again, why don't you join Joseph on this? Mesa is not going to accept
> > 3 different drivers either if the hardware is similar.
>
> Gabriel, on the AI question you raised earlier: from what you describe
> (most of reMESA generated with AI, built partly on earlier RE work that
> also used AI), I think you'll have a hard time with Mesa as well,
> whatever the PROVENANCE.md says. Check their rules on reverse
> engineering the vendor's binaries (xpsb-glx, psb_dri.so) too, before
> putting much more into the Mesa side. Here are some of the links Alyssa
> gave me:
>
> https://kusma.xyz/blog/2026/03/26/open-source-and-ai/
> https://asahilinux.org/llm-policy/
> https://nouveau.freedesktop.org/Humanity.html
> https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/docs/drivers/panfros=
t.rst#ai-policy
> https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/imagination/READ=
ME.md#contribution-policy
>
> [1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/46286#note_=
3783031
>
> Joseph

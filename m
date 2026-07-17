Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE75C44520
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:17:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DE8B10E445;
	Fri, 17 Jul 2026 12:17:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.b="CkEEHK7/";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="gA8I+JsX";
	dkim-atps=neutral
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67DA710E445
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 12:17:18 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 6CA04EC016D;
 Fri, 17 Jul 2026 08:17:17 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
 by phl-compute-04.internal (MEProxy); Fri, 17 Jul 2026 08:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1784290637;
 x=1784377037; bh=qwffd+MK4v483+LcaFb6T74cP0UlMdAs+/sPit+FeJg=; b=
 CkEEHK7/KRIW2r3ZYNZx/CS6/X4GxmPFA90cPBJlDvb01bHYpjCQ0QQ/SF04lBjM
 DpkRhrBWzdn0GVP/59Xgh5KiCYLTj/adksJ9D+YublAzHiXKqydCVz5F2MHqKTNm
 Y/YntNbmSaGOmZ3UkAnmfRsriVVl2J4fITYyxB1P64Zzl8ePe1y0yB+BKAY2vECW
 G2rGhhxqGojiCrZhX6m+DVR9mSgUziAKdnAqcux7UAjdEeDpHqWCrFJf1o/bVhPZ
 372S8VOtD3WgdEs4HsknmguJpIldB1BbwbSh95UwqTRs02qPWeTw0TMVSwkY+B+u
 YStt008MHHpRPc1nbKJUeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784290637; x=
 1784377037; bh=qwffd+MK4v483+LcaFb6T74cP0UlMdAs+/sPit+FeJg=; b=g
 A8I+JsXLlJE2XJgz7nfW9MKgN0RxDW4HvBL7TGLlPlGGUfezGjRybepzB76bIS4d
 DRuCzT/MqP3+xpyB/CChnqq/1s8JUm0c+G5eCU13gjrH0UD9d/EpXOdQSJZctV+/
 FppK5GPt1P4TualkrLJ4h+Au/V9TVM88hepfDpjHixayMVRqyiihITGJPW9Kso43
 +ou0iubCJGTbMN2Fd58B0tdblpOs/oc666GDCZz0Y0Q+sAJqUFcNIlPsp1DG+jj0
 o2XcFj7wEJa6JkHW9Z7FcIKeOJVBJ95AxTH/4SlfFvEftl0tCFTLAUoKkRZbcmP7
 fFcDEIftqfBlBbA03yZfg==
X-ME-Sender: <xms:TR1aalFvKlcaERW_GkQ2wUMN0F-g3FI1VTPgyBywRwrv0iWIOaElcg>
 <xme:TR1aalL_TvVM5jxQiK6hwr08OO4jSvjr3YoEx4j2yUbUqjrovtrnfdDZQ2Z8FgJsV
 _qxfZ2USH15vwhxl7WKCVwXy_4DfNMsI7UQTkmj2pH6GtYfRzyD_f0>
X-ME-Proxy-Cause: dmFkZTGZYN2MueblxAGDt1BtTf+5AWiWQBKayHhh9hPnnR/CTpcYP+VyeqU8xamWs0xUUr
 30icLZzf2xcnlPupU1aMcgK2oeMMOTE4d1oeXnPTwKPy9zzFlUNOp1tXHHsxoPEKK8gt3i
 i9FRqHqG0ujD2olFXKmdrxJTMtz/v0vw+rpCxVhYh6UODdqiXNzJKA+4Pc89XKa+17dlqp
 VVELzkDE+1J4X0oH55DuIUetvVVor+TYOQLdqXOwHXJJEBQgf7TSWMpIlMfAYyQDyzkYq5
 gNpdHIo/34zpBHodGZ+sjVmxNclc6JzUlWFCjwpJWsrbnF7xuD6ktqe142QTVOwOpSqEgX
 Bzs6bICjk+sETAZAF3+rxL66tuRwu/VAUSxbqOISOsdg+gKEY1tBuUQsPpdiEzcKZzPKA7
 ZRNymw2DVCcQHTQ/Uv9IJNexYbDRL7JDcZ2PlvzRtX0Q1uKVhl1u7hP2iXtjE85t9vmAc6
 ykgIoFpn5bthGxWnVMvnh6g7Hx1B+zciNgH76MZFoC7bp0l+wCzcdMfbjaog58TjRZD63x
 jow6AIWiJgSjwW2FXeiE1lCiB8p6zDxy738KB19JScpQe5GA47THc0PpIY+2BvQI9GOJ5Z
 vpVmczjbzp22d1kpMveky64WroJfQgN7wq1A5w4M06EZ9lKkQdrg/c7pcn7g
X-ME-Proxy: <xmx:TR1aak10URcDeLFeSlwiCSJBHJb62rJqKaejbt6DxFWnfdzxJPLfgQ>
 <xmx:TR1aallSlX6lpRbAQuxuH8sUjj-l7Pw5deup2c-s2tLiqPpq1fX2DQ>
 <xmx:TR1aaq4Qhr6WMG5ZCZ2vc1pslCLthllJ_Yok_GZge9ch4YrkRnCdjg>
 <xmx:TR1aagm6I-Rg2J4sXytv2WLfrAvCTKTzd0CzW3tEhYG6grVgRW2uHA>
 <xmx:TR1aamrLsFxz-9CqXGjPUdxEWWSkcul0RF7PnPtM69e5hRKmkP3MIkZe>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 1D22B182007E; Fri, 17 Jul 2026 08:17:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: A5D9awIj4ZLo
Date: Fri, 17 Jul 2026 14:16:36 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ryan Roberts" <ryan.roberts@arm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, 
 "Mark Rutland" <mark.rutland@arm.com>,
 "Jean-Philippe Brucker" <jpb@kernel.org>, "Oded Gabbay" <ogabbay@kernel.org>, 
 "Jonathan Corbet" <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Message-Id: <5049af19-47c4-4ab5-bb4d-6b3cd54ad75c@app.fastmail.com>
In-Reply-To: <20260717104759.123203-3-ryan.roberts@arm.com>
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <20260717104759.123203-3-ryan.roberts@arm.com>
Subject: Re: [RFC PATCH v1 2/8] misc/arm-cla: Add launch operation helpers
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jul 17, 2026, at 12:47, Ryan Roberts wrote:
> From: Jean-Philippe Brucker <jpb@kernel.org>
>
> CLA commands are issued by writing optional payload registers,
> programming the LAUNCH register and polling LRESP until the hardware
> accepts or rejects the operation.
>
> Add a common launch helper that performs this sequence on the CLA's
> local CPU, waits for LRESP completion and translates launch response
> codes into Linux errors.
>
> Build accelerator reset and register read and write support on top of
> it. The register read and write helpers split larger accesses into
> multiple launch operations when an access crosses an eight-register
> window.

I'm a bit confused by the MMIO register access ordering, if this is
not a normal AXI attached device with a DMA master, I think it
would make sense to better document what it is.

> +static inline u64 cla_reg_read(struct cla_dev *dev, off_t reg)
> +{
> +	return readq_relaxed(dev->regs + reg);
> +}
> +
> +static inline void cla_reg_write(struct cla_dev *dev, off_t reg, u64=20
> val)
> +{
> +	return writeq_relaxed(val, dev->regs + reg);
> +}

For regular devices that have a DMA master, you cannot use
the relaxed operations by default since they do not serialize
against DMA transfers.

To do this properly, you'd have to define separate cla_reg_read()
and cla_reg_read_relaxed() helpers and then use them as needed,
ideally with a comment for each relaxed instance to explain why
that one is both performance critical and safe.

If for some reason this accelerator is not a DMA master (e.g.
because it is implemented through CPU microcode and accesses
the memory through the CPU's own load/store unit), that should
be documented here to explain that you are relying on
implementation defined behavior outside of the normal driver
and memory model.

> +	/*
> +	 * No barrier needed because accesses use Device-nGnRE, within the=20
> same
> +	 * memory-mapped peripheral, so accesses arrive at the endpoint in
> +	 * program order.
> +	 */

This comment in turn looks completely useless, as that is true
for any MMIO device. The only barriers that you'd normally need
here on sane architectures (not Alpha) are to serialize MMIO
against DMA.

> +
> +	if (launch->data_mode =3D=3D CLA_DATA_OUT)
> +		for (i =3D 0; i < launch->ndata_m1 + 1; i++)
> +			launch->data[i] =3D cla_reg_read(dev, CLA_REG_DATA(i));

Instead of the open-coded loop, maybe this can be built
on top of __iowrite32_copy()

> +/**
> + * cla_op_wait_lresp - Wait for any LAUNCH op to complete.
> +int cla_op_wait_lresp(struct cla_dev *dev, u64 *lresp)
> +{
> +	return readq_relaxed_poll_timeout_atomic(dev->regs + CLA_REG_LRESP,
> +			*lresp, FIELD_GET(CLA_LRESP_PENDING, *lresp) =3D=3D 0,
> +			CLA_LRESP_DELAY_US, CLA_LRESP_TIMEOUT_US);

Similarly, the readq_relaxed_poll_timeout_atomic() specifically
does not wait for DMA, so you may need separate helpers for
devices that can do DMA and readq_poll_timeout_atomic() vs devices
that never access memory and can use the relaxed version.

You may also need a non-atomic version, as blocking the CPU
for 100=C2=B5s is not great for realtime workloads.

    Arnd

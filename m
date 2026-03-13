Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB9E105F79F
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 12:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7415010EBC1;
	Fri, 13 Mar 2026 12:00:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="rTDMwVMu";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CBB110EBC1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:00:29 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-48534e9076fso17411385e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 05:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773403227; cv=none;
 d=google.com; s=arc-20240605;
 b=QLg7t4zy089KiT3FVo/6cQ4NgY6/DPtq1kPJGrmpocYEdzg1KP0DvVTfLFFDUsyhlm
 EL77QPw+JsNevKQzuQJmwsP7NaeGi4r65Pvy8FGZ8hWKB4jW2BhA/n+G6VhOcCJY6417
 WMTlLDob1B83FmaLAtMnaL4IRi2MiwbcNNOzeAwgYyh6PN5UN3xNIW96ihOfjgLl9M1e
 15rtI4EC9exYsa/6ldb7ZAqxTTLP671gP2T5Z68JdBcVbrUtOAg3NFLShmxMgH24QHvJ
 nzRPaEPQFBWNuC7V/iW7KcWS0/EO842JeTZRUS2kbiRYJlm1jVgmwHTn8Mq/L4Pst6Ct
 iP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0LTIFZfVSy/HsNH3KObZHOq0ZyU515+2Giryrm+nhHg=;
 fh=VheiqWkOCbU00KWPSwxbq6ZbpRRBSWAVO30AA8Q5TtI=;
 b=elkepKA0XL/xInZN+L/t2kS96cHruxLTyDkeCcjLBE7OUskAKRKDztE7vayXf4ZESM
 ecupEL0TUPGdrR9mj0u/9j7Inj9upiRoPTbH8g9h4+2SjRZuLy9M2bnPJ5rxgAd1kJcH
 4qOzizzUSwt60a/NEK9aNfjBU7ifTAq47m0Xql0JkCuZPBKFGzSJ0vD3waM1oVUQAuyj
 jEm/dS70X2Y6qGLD2BWY3e+gaWSHdTYe22B2o6q1NLYUOdrzzq40w2HB0AIhMGjkp5Ic
 LClL8XbSD/a2DlLxp7e+TQ2mhMx1AVvDnh+qvJS2s8pOV1u45CD0M5zpfw9FUz2Xxx7k
 v3Eg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1773403227; x=1774008027;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0LTIFZfVSy/HsNH3KObZHOq0ZyU515+2Giryrm+nhHg=;
 b=rTDMwVMuG3ZQU4zuKmwOe60YMXzBFthJ4H7weyEfKKDQ9cfHfjSKJTokHpeuoErg5S
 MEdKOrv07BQd1dFi0U/zuhfrd7/gaZL8bJATcuQbpEB7wHc748PMVjoMw4vFY12m9Lin
 7Nnb7H5B3cPWub+SECg8K7y3Om3rO+qCIrtQQRa6aWfoMfYeqPIH3Sx3T2ncbkuhEo6i
 9M4af977GeVThV/hNRouI3dVijWLVw3q0xnLOvlNBzfmR6QKYlFgL3lh7keFUaW6hpUq
 nEizPt68u2CL6lOsLbL0hGcRNPV7MYT9X0VGry9mqRgVjgQuWJIXe4JjMHe3BW+dVNiQ
 VUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773403227; x=1774008027;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0LTIFZfVSy/HsNH3KObZHOq0ZyU515+2Giryrm+nhHg=;
 b=mxZF5nYuRlpGiB4zTLOxJNLaUxDlGe+WrHpUL4WdQZyxfjhnBZw9q6CV6UE5uab3JL
 qcVQ6KbnKpNGvOas1xqqAqlVJAGVMLt2O4gAjCDRRdClQji83GJctUNi/vEiKJs3x9w+
 E412+qrVu7R59jBWwTtAHzbSMEQbcW5CYp7SKf8ye6rWerq+SpLSX4/lPaUaWX2ZoG+R
 PA7j91QOmZS23B4dh6Ph9Hl7HUrISBLPfnwb9Mk00dDo1I8zfGbBpgAjkDxK2PbuLDZ2
 2SS8u2UvjxKen4Wg6Fb2Im2P8WqpiHPRTgqFPCT1+Mju7J4nohKPJmBEv+3AWQ9ZyLNg
 OTcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrX8K6tLLcq5V/QcbSY3qU6sl79RpwovCzSzRqbEaECBR4WArK1JZcte4gqy5AIEwoM2n31EUaHNw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwilQ1MEZL//4uon9kMy4obTRd3tKEpjhZEjORVWfsBj33Q0SPY
 VfrCz7oHmsxD62TzoTSmvO9FXi8W92i+BzYcizmm+UfoRsQyvC42E4ePLdgalTQQdH69Ptg/tXg
 qfe63I0w9kTBa0n+BEH+xfxcgkcheS9jwRVv+i+/m
X-Gm-Gg: ATEYQzy0YNYivBBPrSFBtylvhpipCIGHRsPAtkmyg6CvJMZCz5Yanvbyl4FDoRdSqnK
 EkzHiQdgvsatYyzoTXt/I/QPzcHUcTJfNQnLucb8/e6rZEXL4kiqRFT1orSQqQGIndlaLkBKrU6
 EZt/bZg7WCLd3lGYoz70YZQQTHqM+3rAv+PL2srCPTC3KLOZSts4zJ/Fw+a50Iq9DK2IVcvjpmW
 A3lSHclg6+qzaTFUIr/RtWvna+LyKVePUbC0ZdewFYHV4EcSUgog09BnfiG9hFep01H42IPW3UP
 lainHNE0VALRUPzFLPlxRNLwJW+VYlXi9ttAjXC0tpr6nvmE9Ws5gNTOI/ybT+y8r7Z+KA==
X-Received: by 2002:a05:600c:a08c:b0:485:42ba:fc8 with SMTP id
 5b1f17b1804b1-485566cdb46mr43616275e9.4.1773403226928; Fri, 13 Mar 2026
 05:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260313091646.16938-1-work@onurozkan.dev>
 <20260313091646.16938-3-work@onurozkan.dev>
In-Reply-To: <20260313091646.16938-3-work@onurozkan.dev>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 13 Mar 2026 13:00:13 +0100
X-Gm-Features: AaiRm52mH5ClK1vq2lDPbEjgPagq8eHcfKd6sbRZuNsCe1ubX7r91PcCPwWlYx4
Message-ID: <CAH5fLghXAYsa6NJY0pt6cq4qYiB1ZDAatyGM1GCj+xcpYy9-cw@mail.gmail.com>
Subject: Re: [PATCH v1 RESEND 2/4] rust: add Work::disable_sync
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-kernel@vger.kernel.org, dakr@kernel.org, 
 daniel.almeida@collabora.com, airlied@gmail.com, simona@ffwll.ch, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Mar 13, 2026 at 10:17=E2=80=AFAM Onur =C3=96zkan <work@onurozkan.de=
v> wrote:
>
> Add Work::disable_sync() as a safe wrapper for disable_work_sync().
>
> Drivers can use this during teardown to stop new queueing and wait for
> queued or running work to finish before dropping related resources.
>
> Tested-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> ---
>  rust/kernel/workqueue.rs | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index 706e833e9702..6acc7b5ba31c 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -530,6 +530,21 @@ pub unsafe fn raw_get(ptr: *const Self) -> *mut bind=
ings::work_struct {
>          // the compiler does not complain that the `work` field is unuse=
d.
>          unsafe { Opaque::cast_into(core::ptr::addr_of!((*ptr).work)) }
>      }
> +
> +    /// Disables this work item and waits for queued/running executions =
to finish.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Must be called from a sleepable context if the work was last que=
ued on a non-BH
> +    /// workqueue.

We generally do not make functions unsafe just because they might sleep.

Alice

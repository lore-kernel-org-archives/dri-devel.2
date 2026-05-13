Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7B8CD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 16:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D236210EF71;
	Wed, 13 May 2026 16:46:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LM6/UWB8";
	dkim-atps=neutral
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com
 [74.125.224.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8053B10EF6D
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 16:46:12 +0000 (UTC)
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-65c0bda7f15so7585301d50.0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 09:46:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778690771; cv=none;
 d=google.com; s=arc-20240605;
 b=iGChqstOz3FtnsXil6WFBUIRCbo3LazBwb0DW34b3I0relfspRdbxi+E/FP79coa3R
 OsUFU4amVXWwA6dDjoL5M0IcnAX+sR8MFFiPl4hX8XyanheXazMhoFMht4Ftg2DkYclr
 hQiFCAfoSAUSFv5PhcfEXI4LO/kYG+5qjpaYgBAzdexVptikv4zpPx17q0970lGhA1ZE
 dztkfcckPAaY8CcyBFYFZrpafqWQlW3pPomnSacvnF1IeqoSy4CNZVR1RmtRPlJ/I4Er
 EsRrYkU3XFfhqF4PwIwLlcEsqtjtEkAnx0zNgp7xOCk2h440oWhtcpR6/UfuTc/ArS8b
 B8DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NtX+dzLjYhqQH1yNdVLB6YLyksPa2PRCqVlfc29EZXU=;
 fh=vOQeaJcJOoaMlSeQPL5RUKtuePvjHbS/Ub/LsAvQ4Qk=;
 b=dI3veH2oRDM/LeYhgIQfI+wsWrxrWCY7NhiOp2WC7gRiyaPxSdTfd355MskoccVIT5
 FXgl8KqlIGL/bxJyrBPnVXcuJAutwg3+CtFO3enSCciQ6PpdSFpQfNJltpeFDtr1wmBa
 98Lbv/8yPE8QlCsXMiHPgyPRkLOq1hYFbRgw6UVGRz8cKlfQHzQEQGpTEuQ+VmVVwhMU
 sJV9ZwfjIxN7QFSKQ2ixbJEUpTqlqD9zdWVNUy2bSqPZiiCcMJxZRvH1H1P0l8gVMXnH
 iNzvMewO8gIJxwTdVokGJek7VoCpC+M3OUZcD0GoSRxZaJOQk4+cCbZ5wg8alArqeQRS
 QYkg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778690771; x=1779295571; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NtX+dzLjYhqQH1yNdVLB6YLyksPa2PRCqVlfc29EZXU=;
 b=LM6/UWB8GJuHBNlPDIaQE8BbXVdFD09x7EiElvpO4B5zPngB1zif4fjKCByOIG2osf
 VIRuOAtbk2DqeQ2VoCazrlUDVQbpDc9rFK7HBCRDahyxbSrhtxWaz6RpCZ+XQLuOszj7
 OmImc/I8nLvQ11xtD3NoTzw9mOz1FhmEw77AXCDA6yHYfpXgUOswwNi5n10z5fjD5WIt
 1O2k2Rrt1f0TI7CqakslKsy7wu2d/JQhym/JymNIGm1zxy1ssTfugt1TVKwdLx9Yk99q
 bkWk+CY3JcW4XKTHPYfG5uQ/lJzEONMtIjYORVsRhmRc84mAzwfew07aGDxuAigeRsY5
 zCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778690771; x=1779295571;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NtX+dzLjYhqQH1yNdVLB6YLyksPa2PRCqVlfc29EZXU=;
 b=blPVkpQKp1oWog6+RYgsvymPcCXywjaiPutx+1m9QkkD/Tp+yJim5RAR2YmrTfgkap
 gRkuYBExG5hio5NOPqTZjQsa2GsCSHwgoMTjfpMuCTubalbZdYUHPruZlWmBtuIV/BBy
 TBulnIHluRTzCGHNBprQbw94ikWwaGRqYDZFPmdtfBInNya6K0qoAtvirH5OC5VbvkFC
 pm8aMca7taJgNSd+oW67EZ/VQawQKXSfVApQDhHndua8pqky4bG4jH1TwwcvZbWRUJex
 lmAGusoodJm12w/vSrj9oFw3Jw6L8GZPzdzVQoHB3pMfT3qXMd7H9hnrQj6xo83HiL9t
 COpQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qHIea/SNMlLgmAlQ1i6t87sJFZJSGf3H67/WX6l5zy5ZehiAw1I5qBl36n8D9HQ2zrIEpSkicsCI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yztw9fO2VqplWXUr5Mm+MvhVP441Le46I37NtI6b/8haeh95Aqx
 ixv6Bs2Ayjg1qncfvuLDpXakAsDAA5cXZK8QYFQTRpxjoIMyaDRTCgDtqjtVL80z7HgB3W+vzIm
 +F1HU0MoPwZ7zIVkBzojP8blyZkeXGm0=
X-Gm-Gg: Acq92OF5xfkKlFmXbythjMo0HnwVSGtGXTVM2QOpAW6xs0PbBRTRik0qOfaDos2b4ea
 0PI22uFXRe/41+flWQubGnsIm5ttjbMRaGv9RFX8myzBuEc2dYMhVIgcbLSIwiRdEDzM0WP08mm
 Op8sasB3k1WUuoI9hkgozykyzH2ZVl2fTV60dUT9U73BMuRSGd5rOMODywPdPZMff2X68Jbk92G
 tQJ6/jzUvce51nIXGzKwzVWEFL0IMiJ9nzycHVljVvgLaqUg75PiBsUn3kE6cduLjzNn38qANOo
 Q3lH90WpA2fvGxI/OsX9abFhU7ADcCWoeN3SL6ezKbyeEDpksrsTYkKV+B8XSLbWiWBFJhMt2w=
 =
X-Received: by 2002:a05:690e:4419:b0:65c:391:571c with SMTP id
 956f58d0204a3-65df6343bcemr3250812d50.49.1778690771497; Wed, 13 May 2026
 09:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-3-95c614a739cb@collabora.com>
 <CAPaKu7Q1KDzWgCT-5Eo1vbHtq_qHAKvtNt7isvZA57dqFPfqUg@mail.gmail.com>
 <20260513100348.338c31d6@fedora>
In-Reply-To: <20260513100348.338c31d6@fedora>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Wed, 13 May 2026 09:46:00 -0700
X-Gm-Features: AVHnY4LhRy9FdzC_HSehnZRssFOSxgBjN301Koria-4546y0MhLqqeTXYXbhFgg
Message-ID: <CAPaKu7Syxzdpw5wq=gvd4anORaYrpE+B66UYp==Hm7_EMzxnEA@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] drm/panthor: Replace the panthor_irq macro
 machinery by inline helpers
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Wed, May 13, 2026 at 1:03=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Tue, 12 May 2026 11:58:30 -0700
> Chia-I Wu <olvaffe@gmail.com> wrote:
>
> > On Tue, May 12, 2026 at 4:54=E2=80=AFAM Boris Brezillon
> > <boris.brezillon@collabora.com> wrote:
> > >
> > > Now that panthor_irq contains the iomem region, there's no real need
> > > for the macro-based panthor_irq helper generation logic. We can just
> > > provide inline helpers that do the same and let the compiler optimize
> > > indirect function calls. The only extra annoyance is the fact we have
> > > to open-code the panthor_xxx_irq_threaded_handler() implementation, b=
ut
> > > those are single-line functions, so it's acceptable.
> > We might want to __always_inline panthor_irq_default_threaded_handler.
>
> Yep, I can flag it __always_inline, but I'd be surprised if the
> compiler wasn't always inlining anyway, unless you use more exotic
> optimization options, like -Os (not even sure that would be the case
> with -Os, I didn't check), at which point it becomes a user decision,
> and not inlining is probably fine.
>
> > For the rest, do we want to un-inline them?
>
> Most of them are super trivial, and I think there's benefit in having
> them inlined. Again, because it's not __always_inline, the compiler is
> still free to unline, but at least we wouldn't resort to LTO for this
> sort of inlining optimization. So I'm still tempted to keep it as
> static inline helpers defined in the header file, unless you a strong
> reason to think this is a bad idea.
No, no strong reason just that the rest are not hot enough to inline.
But there is no harm to inline so

Reviewed-by: Chia-I Wu <olvaffe@gmail.com>

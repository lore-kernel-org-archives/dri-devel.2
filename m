Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CCBC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 904F010F41A;
	Thu,  9 Jul 2026 07:26:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZFRlI+wu";
	dkim-atps=neutral
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com
 [209.85.221.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5DDB10E32D
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 04:44:07 +0000 (UTC)
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-59d4aa96ef2so203386e0c.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 21:44:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783485846; cv=none;
 d=google.com; s=arc-20260327;
 b=FECg8SZOhzCk+6bR0PjqVmQy6lzOhgStHU9vXTy8hw/d/FolcANROu0DTxTxRgDaxQ
 5b6id3mcwPNWfPasSIE9koA4EbQcpTu4BISpb6wjewOnJQfpiqeUhZQ18TuIL5a3I2dD
 gRdapsAkQp1vfPVJkKdzYm6keGGB3g/Uq63ctOaqvrhddL+1D9HGoZiR544d+eGBFLd1
 KZjp4SfdEjnT3BBLWnxKas5S1ssabrXekg3/MG6MEgimuATBp+pTC67HOM/ceNoIQJ5h
 kOhEyX5e4In3qU1qmkMXgIexQHqB6i3vZiUZoswqwraGj+oo/F3AkN1sYhOu0lQ2MT+C
 BYRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ivD8xGfzRSca2GiAD/6IxHjGWSf1EBJsfgumG145RGQ=;
 fh=1V0lF/BJ07Wn41+LirdBYO0kQonGU+rcs35IsTydTlA=;
 b=lwZyvRj1OQwVaLrfnV2AJTIDnwAMdmgwtO19xp+iZKBnDmttpowulDNDvefi0qqAA3
 PSaw+jPoo+Wq97pqEXBQRu5GWmSp7WXgIDcy91FX3yB3SMj5V8SgSrFd7kjcaVHnEZq/
 xwQgWNrtM44T0rwkcWIWyVo+zcjKZeuDj6WYaaks54jq8HQanXU1Tr2Y5Y7cVNFRfM/9
 37CR8TlW60NkI7PkuhCOthmIvFkzJMqIIh5tGmenNzgL3fe6czveAVrkAc1sZz26CxPx
 xC3o8okb9ot2li/yx3R+IP6JWtMfz4LdWIph5wRT3JcaVQby3Rc1/bXbUnqvKCanQ76K
 HOYg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783485846; x=1784090646; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ivD8xGfzRSca2GiAD/6IxHjGWSf1EBJsfgumG145RGQ=;
 b=ZFRlI+wuNHPhZaDBiHL83IdCR5nXHCIQ8X0qZvIFPZcFBUlkV+apbnpWHjpdgxJcAD
 IOJr//44wyFHq43nOBDfTnTRi8UOnmYFgwh3qDq9PxljfSMimZQ5iM87Lfct2wrFlvZ8
 0K71fvL0LVUsbJE2LG3KXMemmluv3zohqCXPeZ8P5qRLu7BDb7X4mqGeWgY/8FM7Iv4U
 xbT6X3SYBfXwRPAP1cfpFl0r4dmUaxE09uvkUS3tE10y9C2H6Cxjaw8OtDGpgAyTzmf4
 TS4hVpc2sLDhfuWgQfY6UvTO/BvoIdqXeMX63w2nnnEQVyBkEDpcvHEv6kfcDPRAKMmP
 71tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783485846; x=1784090646;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ivD8xGfzRSca2GiAD/6IxHjGWSf1EBJsfgumG145RGQ=;
 b=WlxCT9Yjz3C1VoiDra8jeLIhUm5k6y4UBT2gBoHUyY8aa8SdkErMBWNk/CvVHlV7IG
 5tk8T2z3TuYIHLiFpMpGK9iLPHQKbhkJmuDdIeIY+hGr9E+HLP4OfIm7vZBx8b83XdP/
 3WMtDP5puO7S/LVl/dkwVsv1wtnbamcVMG/r1WG6D4DiK29qWVhAaxfoaAWw8oHqQQsb
 zNhdAdrgp/lQ/Ceq576bVzRAihWvqNr5E06C6BHDtQwn0IcH/UbtdO9HX5QAR/jaQblg
 nsPKGfpNMkkRM+PVIPBd3H3/sDcu1B1BShF9/cebReIIrD2QaPnuvPk7Dq1kxM7Q/uhn
 T/OA==
X-Forwarded-Encrypted: i=1;
 AHgh+RojVdUaYKF7avx6kRvuruPeIEBLtYtgLUZBMyIltSkHXRPfiv40C14N9yY/rpvfEgLT/oraEuPbJhw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyskFTR0FgvaF9Snq517dUGyPtZR6bPG4KYtLcyxybg5L/e6eQx
 wWaeJKCcqQfBTC/C5Ri6bdxGtJYUIAP/1Nyu21Q8iBRtcoLyWpou5j4vUXGaqnGnEbkSHSntSJA
 jk2HBu7lcoFEoOKHB38k3+kC/T/sjSJ0=
X-Gm-Gg: AfdE7ckbzehfzPJhxen40GkGyiH/6vHVHNM5kJ9g1T2StXEkJe1bWPiIuiwCPuRZenC
 WbTeOTC+mmWOUKtqCadufRyAHmKj6GyqA8AoCyB7/DRdTdJzhtNDB7v9S/p4jK7FeumGEo2zQCC
 Fp4T49bTm5zFTd4w5L2XKAerwFxnnPWhIl1/yS1ltBYqNFkaIdzkp0gt2QzseSAWPjMC8XTnfKF
 ohNSyfAuBo8keWTg/OA1g7tVNZnyxFTIwMo+16uLpuNW/xBAZeFeEXF49zFSQyP3BGYExxdEEJo
X-Received: by 2002:a05:6102:598a:b0:737:c272:92cb with SMTP id
 ada2fe7eead31-744dff2bccemr346390137.15.1783485846293; Tue, 07 Jul 2026
 21:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260707150544.2272933-1-ruoyuw560@gmail.com>
 <CABQX2QPRk0F1A4tPg=B8-H6DOOudRdU6XiMzH3PhYtgcNYeG=Q@mail.gmail.com>
In-Reply-To: <CABQX2QPRk0F1A4tPg=B8-H6DOOudRdU6XiMzH3PhYtgcNYeG=Q@mail.gmail.com>
From: Ruoyu Wang <ruoyuw560@gmail.com>
Date: Wed, 8 Jul 2026 12:43:41 +0800
X-Gm-Features: AVVi8CdzPk-s3YdKXE_ApafwJ2pcQ3axB8tJ_X9WZrYqMUx9Iw2O6sr2v_dJGuM
Message-ID: <CAK_7xqzzHza8fzWO9P8yx1WaM+b=GB-UJGSeq4hW9pPhYvi-Kg@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: Handle MOBs without page-table BOs
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Ian Forbes <ian.forbes@broadcom.com>,
 Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Type: multipart/alternative; boundary="00000000000054917906561228e6"
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

--00000000000054917906561228e6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the explanation.
I agree that the analysis in the commit message is wrong: tbo is the
first member of struct vmw_bo, so this does not create the NULL
dereference described there.
Please disregard this patch as a bug fix.
Sorry for the noise.

Ruoyu Wang

On Wed, Jul 8, 2026 at 11:35=E2=80=AFAM Zack Rusin <zack.rusin@broadcom.com=
> wrote:

> On Tue, Jul 7, 2026 at 11:05=E2=80=AFAM Ruoyu Wang <ruoyuw560@gmail.com> =
wrote:
> >
> > Single-page MOBs and small OTable bases use depth-0 page-table entries
> > and do not allocate a page-table BO. Their existing teardown paths were
> > written to tolerate that by checking a local BO pointer before reservin=
g
> > or fencing it.
> >
> > Commit 668b206601c5 ("drm/vmwgfx: Stop using raw ttm_buffer_object's")
> > changed pt_bo from a raw TTM buffer object pointer to a vmwgfx BO point=
er
> > and converted those local BO initializers to &pt_bo->tbo. That
> > dereferences pt_bo before the existing NULL checks, so depth-0 MOBs can
> > crash during OTable teardown or MOB unbind.
>
> That analysis is incorrect. Nothing here can crash. &pt_bo->tbo is not
> a dereference. It's address-of-member. tbo is the first member of
> struct vmw_bo (offset 0) so &((struct vmw_bo *)NULL)->tbo evaluates to
> exactly NULL. The entire patch is basically a no-op. If you have some
> decent static checker that's being tricked by this code and there's
> value in unblocking it, please describe your static checker and feel
> free to resubmit as a code cleanup, but the above analysis and fhe
> fixes tag are incorrect.
>
> z
>

--00000000000054917906561228e6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the explanation.<br>I agree that the analysis i=
n the commit message is wrong: tbo is the<br>first member of struct vmw_bo,=
 so this does not create the NULL<br>dereference described there.<br>Please=
 disregard this patch as a bug fix.<br>Sorry for the noise.<br><br>Ruoyu Wa=
ng</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Jul 8, 2026 at 11:35=E2=80=AFAM Zack Rusin =
&lt;<a href=3D"mailto:zack.rusin@broadcom.com">zack.rusin@broadcom.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tu=
e, Jul 7, 2026 at 11:05=E2=80=AFAM Ruoyu Wang &lt;<a href=3D"mailto:ruoyuw5=
60@gmail.com" target=3D"_blank">ruoyuw560@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Single-page MOBs and small OTable bases use depth-0 page-table entries=
<br>
&gt; and do not allocate a page-table BO. Their existing teardown paths wer=
e<br>
&gt; written to tolerate that by checking a local BO pointer before reservi=
ng<br>
&gt; or fencing it.<br>
&gt;<br>
&gt; Commit 668b206601c5 (&quot;drm/vmwgfx: Stop using raw ttm_buffer_objec=
t&#39;s&quot;)<br>
&gt; changed pt_bo from a raw TTM buffer object pointer to a vmwgfx BO poin=
ter<br>
&gt; and converted those local BO initializers to &amp;pt_bo-&gt;tbo. That<=
br>
&gt; dereferences pt_bo before the existing NULL checks, so depth-0 MOBs ca=
n<br>
&gt; crash during OTable teardown or MOB unbind.<br>
<br>
That analysis is incorrect. Nothing here can crash. &amp;pt_bo-&gt;tbo is n=
ot<br>
a dereference. It&#39;s address-of-member. tbo is the first member of<br>
struct vmw_bo (offset 0) so &amp;((struct vmw_bo *)NULL)-&gt;tbo evaluates =
to<br>
exactly NULL. The entire patch is basically a no-op. If you have some<br>
decent static checker that&#39;s being tricked by this code and there&#39;s=
<br>
value in unblocking it, please describe your static checker and feel<br>
free to resubmit as a code cleanup, but the above analysis and fhe<br>
fixes tag are incorrect.<br>
<br>
z<br>
</blockquote></div>

--00000000000054917906561228e6--

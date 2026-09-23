Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F66C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 16:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80D9D10E93C;
	Wed, 23 Sep 2026 16:23:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="L5Exb9se";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com
 [34.2.64.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05F2C10E93C
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 16:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790180636; bh=ZioDPWqJiL0mKCEXTA3Vjm9OzhNI2ylPhIhL0t3UoOM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=L5Exb9seRAjg7pqzSuErjt71g53Hqs2RfUpB9LE/JVW0r8zgeIhe+5KIgXEWJUDd4G5sU6tB27glwwHPWK2yMXqOw+p+erxJU5YaWER1Z61PjnY3S630rymfHKF18k6l4gApUGEVflIXVKrwU69LR3piwcV0imcGaee2ugEOz1YEpRlbSaKwnn5RMVn4qJ0rArfWLU5ut4G6SjfPC9iRkkGDwt4SOIJAR21ctDojnVi6jTx/ZwS9mhXbmml8gs4ZWAhCFoaLIvl/ASv1BcFs/WwXSSufGDi9isFwTPrg3EgYqSOZsqsyhi+BjN186za4+QT7vLEL5nqtl6SVpysp6A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790180636; bh=worFOcwpJZs+WYjNZ3yT5m53A7OKiUAJasl2kVAUBDo=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=SgRvyAYIzoQZZ68JDCHb2Tb3qYO812HqEUn80K1MROT1Wz/evOa/GNAjvNQ4n9f7r+Lo9C6VHrKGUXKlnHeQs9oEeLSFqoRSXmaS/UTxzd70qka/piPtyUUhv2Pka/yuBg86EnimHHJktUXaCblG4loSVhz+3oYN/nUql+Y8MQNhWCxfw6Om3gZhnlfEDFSn6DrPx3Qnfl78hBWrcR23BIhNin6OEgyoDTHl+7NuxFGN+pXcG45N5Ot5zz0CUaBk1Ct4F/w9ST3oB2eJIgFjDVPjNH0+zoTk+HztXDRXqVtfrzFPls/pxMf53RIYKkasmW9EuQEXlyS2HVfvH0TCAg==
X-YMail-OSG: CtwsjBEVM1lVlH0N9L5CpQDqD47Yg8OEc73oUftu_DeyVBbNqFeYz9b5y4cPvQf
 6ELmR.9p2gDdSGrevlJg_3xrt_LZnoF_6bWYj_Oa0QYGl73oFNyvzFdQk8Ic4REaybwb6C6vJIo0
 Grl7NCxGVdtpkEB4XI8tFPLLmQLcqOK4iIkYfXlaYXbaXkpF.SEjv7xgEKeGhW48Ck2hYvmg03Sx
 DB6g6iJcftXHQlbr_74YE5TJYYEWySMw2vjH10VlMnwPHXE0FOWthbiUxUCWKCh0AWh2lRT.pmbz
 5P6nhl4MXFxZD9YcqWAdIlIatymgs6jAdH5qsFIu6LxHk0bsxbvAFEfkSry9O1WfuDe.2BJUmsLz
 dRnyTWOY.YgEJMQMbw3Zjv78nGxhsXPslgQdCq30vFII7l3jkP7bSeGf8DqUinnKTGYWuKFECiBl
 _gA1.1z8gXPFDHbR93f4PIxtHhiOl4J6ncmFIgVt_I8QHP1i92.kswnO0rPOL0F7v_rqqC.UNIKN
 pLxybHJXRFtUpLIRZSyrTqJnzHhA8HfqyIZpaGZlwL_E3myTrTzb34AJ7gfKmLYlPDuPq7Bvv9YG
 mTrBujQQ5nCxlm.P8XYd8T3TMWrh2sLB50HcwiGbRnElUMfCXby0.PEnIm9N4FZRviyXwH3jD6LE
 cMl0JhZIvgG1mMLfvXpNcC5Gl5taJgiZOzph77lMuXUSVPNFT9V4f7JBTret9.hgZ5xrr5WDCyNn
 W..bshKTlpVCXZSmR8QowACqiE_jY_T_sZmdo0WoJYP8mdgGqyiuAyBdzCxhav7q9ShCTQv1BRVs
 lDA_bcujV2ZTt83Y3SOdFnKt6hBzIuhoSQiJgp7UGSaQeRBwLv4cApWfiqaCNaGjcl2r_T.8vALW
 FeEzGYGMJKGFvGA5iT_YrQA7NIIZJotbhmBEkE4NYaGd9.dJd04J3_LG5DgpFP_mUkYdqCMYIyCX
 jG2UCSdEgHHxFOpRnJ40Yk3tocHCjzUycbGcHGhuISnt10LSI6VBWY1ufZdb7eqMJkx3tsGQ9oD8
 XT5avu9VFxpqVtnmKy44m73DI7G7O9bC8OR7p_wJ7fs2Se0vpViIPwyrolQ4lF0qT_uI0cDzXRUE
 Zbk2SwIV06eGkxakELVHxmUZmTHXjXMhH53LfiE7yGxDhBGl77J.TyM_uPx3B4F4ykd1OjVEmEbg
 LTDpq4dAajyjwatXrng_gke6dLTzUWyC9LkxUgdv5fRR_auhR3X7hnbjiSAV2qcsOjp5b1JZBq5z
 EeIoL74mFRw9lMEnJZgQXk1Ip1yzJz8r7NKYP4rsZhsq0eUuGkHubRq1UF3LMeaRFA4.JDt1D1dU
 8Eryrv1PTPbilFRSGM.ZsYA7oc61fmeFiwIHqWwzRJ4ujNKAQXUFeKGHVjm4y8eADFFuY080vYQh
 RzhWzLvS6zalRd1SeEAPSxa_PnmMFCYMCwBvBzIZZVAtBhIaLK6OeyKdKT6pKpgQh38rV1lpkF2p
 l2SWyf1uGaPNc3fhCxJlqaR9r1iDTZJ_0TDzzooKWGj5OJv5hJS0Y89IojvuUE07ZxFXVWK_CVo9
 QcpLEajeq6hWnvVCxb4pMB.Ubp7hqS8hzpRhtkjYzQEM3iuJlEQ3bQBi2pBDZ4lK5S_u2.7hw4FZ
 8YmYQczo89mv0p4XhS6LmS299pfszDWM9iWd3lU2rrxc7.2v_4jKKrVyRen5Gs7Y2QUBBOEXWllm
 sSVCNcXfpsBNMuHUYDSPOWw3JJlVmdfTWU8z9S_hYUBdYHuAS3U39PiWuc1PbbG86jg9mVrTEuvD
 1aLUhOzMrtIad5nLEGKJ3IUkztiCeCVapHG4Pg2h9k2oADXvrybxu.x7nP4A3yVQqaxOUZk_hf6O
 GMFwxwlwdBH3.biBf.K20x1qoxa7._sNElrSHyZGQHOWqr5SCa_oG6ciTNObNJjC1Wjxh7MMYPLK
 Fpg1tFtFA0hdaMDPpILGFHXx3lEQ6k7dyb1Ddv7pJ3OeerqGNX9QK.WTHs0RYRSaTj7On_ERzuwL
 S3U1tdfKsDKQXVGhqIpP8mnZqPs5rig--
X-Sonic-MF: <Capitain_Jack@yahoo.com>
X-Sonic-ID: 22e107b8-486b-4550-a3cf-696829c31d3d
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-101 with HTTP;
 Wed, 23 Sep 2026 16:23:56 +0000
Received: from dip71.lsn.bf1.yahoo.com ([67.195.177.80])
 by hello (SMTP) with SMTP ID 4e79166d5e8b7af675ee8b3df5f3f297;
 Wed, 23 Sep 2026 16:23:52 +0000 (UTC)
From: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
To: lyude@redhat.com,
	dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org,
	dakr@kernel.org
Subject: Re: [PATCH 0/6] drm/nouveau: HDMI output colour format and
 quantization range
Date: Wed, 23 Sep 2026 13:23:48 -0300
Message-ID: <20260923162348.1037898-1-Capitain_Jack@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <c78df20bd86437dd3987053765a550b3bac0cc65.camel@redhat.com>
References: <20260922215336.612239-1-Capitain_Jack@yahoo.com>
 <c78df20bd86437dd3987053765a550b3bac0cc65.camel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Wed, 2026-09-23 at 12:13 -0400, lyude@redhat.com wrote:
> You need to either tag your work with Assisted-by: if it is generated
> by an LLM. If you did the right thing and wrote it by hand and just
> used these tools for analysis, that's fine.
>
> FWIW, If this was entirely generated by an LLM, then this is quite a
> lot of work and I'm very hesitant to review this. Going off:
>
> https://github.com/danielcamposramos/awesome-linux-hdr
>
> I am very concerned just about all of the results here came out of an
> LLM, according to the LLM generated provenance file, which means an
> actual real person with experience working on this needs to go back and
> verify that all of this is correct. That is a lot of work, and the idea
> that my review comments are just going to get fed back into an LLM are
> not remotely encouraging to the effort of having to go through and have
> a real person look this over.

Thank you, Lyude, both points are fair.

The code was not written by hand: an AI partner wrote it under my direction, and I left out the Assisted-by tag the kernel documentation asks for. I will resend with it on every patch, and the Deep Color series gets the same.
Sorry for that detail: I disclosed it in the cover letter body, but the tag belongs on each patch.
For the record, the tools: both series were worked on inside Claude Code CLI and Codex CLI by several AI partners, Moonshot's Kimi, Zhipu's GLM, Anthropic's Claude, and OpenAI's GPT Astra and GPT Sol.

What was mine: I found the problem on my own bench (full-range pixels to a Sony without a VCDB), set the design rules (follow drm_hdmi_state_helper.c, use NVIDIA's open NVKMS as the hardware reference), and ran every hardware test myself, 25 configurations, checking bars and levels on the set.

The OCSC1 values were checked against NVKMS, not taken from the model's memory; the BT.601/709/2020 re-derivation was also done with the AI.

On awesome-linux-hdr: it is an index of links, not the evidence for this series.
Its provenance file names the AI partners for the source surveys; the hardware results are my bench measurements, and the logs for these patches are run27 and run28 in sony-bravia-linux (tools/stereo-modeset).

I read review comments and answer them myself.

Fixes will again be written with AI help, declared in each version, and tested on the same bench before they go out.

To make review cheaper, I can resend only patches 1 to 3 first (the header, the head programming, and Broadcast RGB, which fixes the visible range problem), or wait for whatever priority suits you or suites better. Feel free to also include it, if you want.

Daniel

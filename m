Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2ADCCF2C4
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 20:00:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 432941129B9;
	Fri, 16 Oct 2026 20:00:41 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 064141129B9
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 20:00:34 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6b1b12de661so2675a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 13:00:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792180833; cv=none;
 d=google.com; s=arc-20260327;
 b=ghe/tHsDaNC1d+5Yydm8DaLgEgP5eE0PFmUisimEMz2lRGeyK+9Rtmk44DNiJRGVPU
 9JVeOkjPCRIGEmuSH6ug0DiSnfgnmwL4Xp+fzn+WMwwMU5PRrxTSoZP4/8nNbBNyeSD2
 eBBdrTxGquS/oefUG2bn1gAwIdBCOIB4aw2BCZZUN1REGYu0HudppALI1EoYtC5F3lsq
 +srEVvzPNqejx78Evhl2qV41dQvFsIQteWxV78sAr+PaYdFgxkfVpPpmgi2d8LBOWRRk
 74MAs4Fbfms66JjUXVfIIFdkVfyXbDpk06nGThJ/WBcD25cHu8Lqe0qdxgNXp/YQdMew
 Z+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Xd6WNmGnzFYlFoHsuTFHOu2fkEqtQQlZiBMErqBBiw8=;
 fh=YriQdl2X5LbjnnAYi4/QM2X/6MpOgfc+mGWKpf8Terk=;
 b=Cq4LseylPc4R5xeehzLjBeSvjh9hyq0ehVliUc07rtmCkdLPZIyT1DzzXSlBXw6Am8
 WfMfZNICA2uaDWs9bcooDXAp8is67ikCKRewQR3UP8Sg9xU19SmaVDjEman0IbW/7kir
 RZ5+5WSDoDrRN/IIZcs2kIH7KA65U4PMbM2zAwvtxPZiFeEjDVcGyBMOWFbwm5+Eg/XN
 maww8TGlMCe+kfvlzDH/xvsafAcJ7MecfnV02PrNFJilS4PyIg2MOIy6srOX1m57SfEn
 6z5R3dVA/G85TgijZgJ0shodXzXKbeyRNg3qcTBSZdulxbb/aL66Yep2W3FuVYwPjfKC
 tAUw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792180833; x=1792785633;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Xd6WNmGnzFYlFoHsuTFHOu2fkEqtQQlZiBMErqBBiw8=;
 b=svG05OniN1zbY4IZqAjAtoMW6d8TB8Yss7ryVlrUlsgVLoD+rkNAS80udGTgicf1v8
 KZUsjnJe7OH0hxPUQVzmcKLnCpTxa7f5ZLp71S8dL3XzscGrVaw6Ep8HagrPt47osS+E
 /jIosl1k7XoolkoZM5xVq1IZehVyDs/w3GUOpYRftOOp/TwyU8mlNd2f9h6AGi35JsP6
 SWc+g17azcI5ufcM+/gXihvx6ylBN+coH6w3lqbR7EWicOQfWUEzYbuyT41cZCHZCxJc
 +UwMRvVtSk1qKl9ptBQFaPabQZSOrB6Y+eCBSjtpXxR2snRxmxP+FPCp9UNf+POQ/1S2
 fCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792180833; x=1792785633;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xd6WNmGnzFYlFoHsuTFHOu2fkEqtQQlZiBMErqBBiw8=;
 b=yI+SxoyIsfYtuswH0R/R3TDwNC+UzkxUXkXHoITZ+d6Gj9voRxqtdL3VTw4Clzl1v/
 lnsYPiQuuybRfJGSM1SEsoP5XjFcnp0nxCGpP/yXkd4TFZcN2N8FdZHb+7jFVVDnu0wM
 M0LKxpvd0yMt8TFVUjFvKp/gfowZ6DN8GxrQZ3CuqpMaiOvh9gMhykEmHX2UMs+q7UEL
 QcPsOLp9HnOWib1/zX08M/Cyq7nL9mDfKDs0VDO7jSGnfYHkssBsH0SOGkHs2Dzr5vC6
 M958BQCDHZNollO9qGNzY5qP/EuuEh5nFVlZBtpPxxP1qiQvZreIuCX5v+gZaDk1L7C+
 ma+Q==
X-Gm-Message-State: AFq9FYIBBfZBqWXQOnWn65spEtnkfI3lrgbx+rfenGiOSNlzXlu+VLWu
 iWp4eyEWycNnERXQCD3jCDpqyWMcREz3/9c2LQPi31mM8ubQBUNZpKV9FtNdi52Zly0hZCxX5xz
 iY45p5LOOw+s4SuUCOBgpINFEMkVjJL6r7OKICipV
X-Gm-Gg: AYBFou0F+IuSGUCspIQcDEppm5MAh2W5k9bQXSoDhk7JGD08LpQMpx9Zg0DldzEXtga
 wovGeHrnZy52XDsE2catx6dohimKKoNluPr3nrK+wfAVGL+mBRelgXraqOnEwIcoZsKTNcuKbz/
 VoLhKxFRfXMR7b/MuArIOv1CU5J1uGqfOskeP+9By6ngSGc8V4A4wx8ASJd4IOMTQQ2fAnWCd/G
 fB8ma8pTfBMDZkCaPWWUHaY0AZSaW34LwZmpoFegDZjtukqO+vYEV+/jPWnmdIATDCt7psDshu5
 03mIj3ZJFKNb55oJBzQ6fek/e+CbXyCXvnpDoAC2/1bZHywRCwBrqQ==
X-Received: by 2002:a05:6402:4406:b0:6b3:874e:1b6f with SMTP id
 4fb4d7f45d1cf-6b3a887003emr14330a12.2.1792180832701; Fri, 16 Oct 2026
 13:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20261015163915.1166043-1-almasrymina@google.com>
 <20261015163915.1166043-2-almasrymina@google.com>
 <sashiko-outbox-174651@kernel.org>
In-Reply-To: <sashiko-outbox-174651@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 16 Oct 2026 13:00:20 -0700
X-Gm-Features: AclHuK8Y4pWXf1mHB6BN61Lfe2Em837RVtKxg99QRS-eFFDNTF4wSL40Y1Cy2OI
Message-ID: <CAHS8izOMzQQ8pXkZeXz3+TZfxATpyh0L00KGJWdu172tZBLAcQ@mail.gmail.com>
Subject: Re: [PATCH net v4 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
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

On Fri, Oct 16, 2026 at 9:39=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] net: devmem: UAF due to leased queue mismatch in mp_dmabuf_devme=
m_uninstall()
> - [High] net: devmem: UAF on dma_dev when physical device backing leased =
queue unregisters
>

Lets see what the netdev sashiko says, but I'm yes, I'm aware there
are pending issues with the leased devices in general and during
revocation. They're prexisting, and there are too many related issues
that my series became unweildy. I'm hoping to follow up this series
with a minor rework of leased devices to address all the bugs there.

--=20
Thanks,
Mina

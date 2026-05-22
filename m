Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDB6CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 19:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3A9B10E255;
	Fri, 22 May 2026 19:47:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="Ml8oQLtP";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96ADD10E2B1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 19:47:30 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2b9fcf7c91bso85205385ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 12:47:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779479250; cv=none;
 d=google.com; s=arc-20240605;
 b=JzEY3g7DW56vH/nJep3O7lwQNHUEWUYB4N/pRVV2Z+vmIaWL8T2QpEYCodbnjWo1ZS
 eUW7J2gwN69wS85FtoTCainOLWB/zZmiOZt4ifWk6TnnIV9FoLeDA1ljHXXoV8G57gbe
 A8XFs9H0FUfXCdxTo591I819bpaoZRJFpvQyzIrXnvvuvLDN4cgwev8ZniW4n959e5Al
 axslVJrPWbyDmSjthqtCLW/pwSpSWuGtT4f/125ZUYHuyfZCrZG7BwLCqNTcjUzq7tR1
 1c8HQCEgYY0jib1DRSwbfkJ7GFe3QW2EbPhJMFy4xbMQw23dXlFWq5oYrn0svQ41Ar0u
 8nfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uKZoHuz1D0wPJnXc8vF7N0fA09Ad+/LLFPunKHYplWQ=;
 fh=piWZGW+TuMIx2L8j5Jl3oHr0lvpsNwe6n80O9HBtrew=;
 b=SpxYgTPGan8cLxG8IEmidh+60yf/yTpaau2iK6VdWM39abMxAJVwLouyHjoN7uv/hl
 XmVMjojY3crY98qC5AMh4YfNuVbWtEaotMhnkr2xaTNaEPRkheonP6MTzJK0JwXjP9hd
 BS7gLsvDFOKFgIQEsYtTaxtPgpIqWo0ITQV0/whfUwTmL8SXNH39ivB0VrtQUBE8yQoL
 2nmEgw8YAki5LUeMKVjobbFzCZLjYDGfXQUAtkMCW0Nu6tGXRJAWxeEP3ZjcOnJlLWdi
 P/1CHJnCwqlUrAB8RqivJfpUymPIck3EubiFsyAN+U7kw9I8eZ5wGXspns2telZ3nWU2
 fRkw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1779479250; x=1780084050;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uKZoHuz1D0wPJnXc8vF7N0fA09Ad+/LLFPunKHYplWQ=;
 b=Ml8oQLtPlF38AX3OOC1WV8pLP2RGjDWLqIC+IoRCRVG2ehkkOtAQE/Y8/64pufeEnJ
 eGQx7ZYuTDXj4a/OH9YLc3s7CBxTueQ9rKLCS5RNUIKb7ZTRUTAlmWB2cZ9fwrgpcqie
 YHTLH4fWJCGfXMlZcCIERB1SrKDDVzo51IOw0PnrIw48ZJLQr35mYQUDd0hoQf8Shfgl
 b40j0BEqKewR67/zGukcNalQUOzZjecyOfvmt0Rsjtz0UFsH2OWkfihuC8fSKelFbWbN
 iBWOvDNyb/OaZHFZ5IhwvIWGTiKEKIOnX8XwWso//pnsuYAj/OB5J7wkBm78FQIAU2X+
 L16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779479250; x=1780084050;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uKZoHuz1D0wPJnXc8vF7N0fA09Ad+/LLFPunKHYplWQ=;
 b=TnccFQ0L30ByYyfDiWXptE+f3pxsq1phIVFdbQKku6+8pDEL0SMMcFjyVauRalIzSw
 0LDNFwABbrUSf6gkU5QGykJFGjXzL9PFyqZk5BH3KVGUMDrjJ/YL5Dl+4vRTojNxPCCR
 MZ3nXPnI16/w6b25ioW3+u8bvaac2U/mH9PY2v0Cn9M99Hl7pYlmqktV7DmGEvOfNYnw
 kf2Wg8N6q6QOcqZe5wiuCzMZsnUw7zpiIuFzssbcbdeQAGSawpZOzYYd/tlJ4ZgV8bBS
 ElvZqg3qNKp8ELrevbQAqrj2Q95UhOmqGIIeEX1DkVjFl98DjqQQl45ootS3EyVTPHqJ
 luxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/X10h/VTgsp/1yWNQZCYvWViDfdpPaDYtNEIv4nQvSheI7tsFlIf0YqVxB2jItxoht1DfWcM3WyN4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxaS/RK7PZN5JyV/iDc7Jh2MPrjdmeCzuxSAgq4DBa050F4U67q
 OMqgO2jOjFh+jGTEGWBWKEnmcs1q9XNpwwShX50EWlptt12z53ghtaVOJsyVN5Vboa0G2toAPLu
 MIZuFKYVYJ5aBXUNKIHSwv8cxdAXijS+E3uHwilTnow==
X-Gm-Gg: Acq92OG5jDub+tayvGEAJrVjloz5i8ZXNGKw8lqpt2XU7pZSKzapW2zpynKrgGP417E
 qgsElJx+wMXR/GgEwElRLcMctXCe8Z6aVeMcIMfDYuws4fr7TykX/g8w+XbMPt0oWHr6+Mrh1cC
 Fp4yNhnm7RdMlvBSrKk7OamqMk0NB+3Pj9r14gvUZAEDitO2i32wBJNfvbaHaA5xt3Jt4MWzeCT
 dxqndU5haJF4oWKP2Pc20aGcJTyR2iogcLzIEt0H3lPDL4cyKvgPTIWbIizP+SVif2TuPRFVuzl
 1zqEv9k=
X-Received: by 2002:a17:902:d482:b0:2bd:6e1c:3ce with SMTP id
 d9443c01a7336-2beb065a670mr55652725ad.20.1779479250087; Fri, 22 May 2026
 12:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260422-hot-plug-passup-v9-0-aef804255986@collabora.com>
 <ZSuf-ENwSXWZM2puVBDxGQ@collabora.com>
 <CAPj87rOiq1i6ZFaeYoeu3jhCRdZPiwdfffHBJ97ihTxmgMJ_VA@mail.gmail.com>
 <nHIzMkkRSw6xN8LBsR66Zg@collabora.com>
In-Reply-To: <nHIzMkkRSw6xN8LBsR66Zg@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 22 May 2026 20:47:18 +0100
X-Gm-Features: AVHnY4JP_IzERCik07twza9ECNS33MFT8y3AWz3T8zJkDBfVengCF9mYhK6BVo0
Message-ID: <CAPj87rPWrwAzY0Yy6aVZ-FcWCE6Ly1-YkK0J8zstqxdPHQ0moA@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] drm: Send per-connector hotplug events
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>,
 Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>, 
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, Daniel Stone <daniel.stone@collabora.com>,
 Ian Forbes <ian.forbes@broadcom.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, kernel@collabora.com, 
 wayland-devel@lists.freedesktop.org, Marius Vlad <marius.vlad@collabora.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On Fri, 22 May 2026 at 20:28, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
> On Friday, 22 May 2026 19:58:26 Central European Summer Time Daniel Stone wrote:
> > I wonder if the safest path which guarantees eventual consistency is
> > to change the !trylock(mode_config) { goto out } path in
> > output_poll_execute() to jump directly to the schedule_delayed_work()?
> > That way we could read and modify delayed_event under the mode_config
> > mutex; the if (changed) path will not be taken if it wasn't possible
> > to take the mode_config mutex.
>
> If the drm_kms_helper_poll module parameter is set to false (i.e. the
> non-default setting), with my patch we'd then also need to think about
> the behavior if delayed_event == true in that case, since it also goes
> to `out` without taking the lock.
>
> I think I need to ponder this particular orb some more. I suspect it'd
> be fine to move the delayed_event clearing + sending to before the
> mutex unlock, since failing to lock the mutex will just make it repoll
> and try again in 0.1 seconds. The event would only be lost if the
> another delayed_event arrives before it's processed.
>
> I think Ville's on the money here in that the users of delayed_event
> might want to call a drm_client_dev_hotplug that does the work
> scheduling instead, but that might be a bigger thing to work towards.

Yeah. That would certainly be a series (ok, multiple series - the sun
has made me optimistic I suppose) in itself, and I don't think it
makes sense to entangle the two.

Cheers,
Daniel

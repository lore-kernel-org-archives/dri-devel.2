Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FA5606A32E
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nhvbXSKe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9C2910E415;
	Mon,  2 Nov 2026 22:12:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0DDB10E700
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 22:12:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7772B42D9F
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 22:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F55E1F00A1E
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 22:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793657537;
 bh=e1YYB8A6hDEHHLeE7ijygK35bswGqWpmgHbadPgu68M=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=nhvbXSKeFAKz2TvfL67iWPjkMQIkR+O3mbwAbG2uKjAc5raQh+WqmuEfYg+dWf98o
 mzvBpztd3vo9fz5NaqQBFv4LGSP6jMVAYMWcX5ZKeWDptLdq8ghIopc9K8UQoRyCgT
 z5LkVUXkImpwb7pYOhPRmfMOIovDOKBR29CVgmQb1Q03MZoh93nRtLKo5cdNGLUCG1
 4tgslehg/1XaowqxEIpsylnfkm3CyBgzF0p2dEcbqc/iFhiXZAcp0GGJUeL3y1aYeh
 vEwu/GfMKQtwDVi5eHR3jfQuUZfZG6EY+JHCm64Qo4KsADuPVTN0fvbAODq/HpNgnO
 2SagBt4UNZt1w==
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-5ba3ec92031so4671105e87.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 14:12:17 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AKwUvByJSS4+3xl3yHj9wz//IkIGyr6AnRtWKgDTzkmJA5xGEPkcEGJbRkfYiHaTQS5FwkT/SlQ2/MJwW8Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+SPiLbzE5PltU7aX3PTCWOYRo8bHZxxqqpwuJXgfrqnzuoJO5k
 C/ZlL2lORvx21Id8aYdfPNGQVFfZQQzvt8JZDxLzyn+t+uQqjrwsGfk1Te5/wIMBvmpxAlqys7Q
 8Y7vMjWhgRp4V6QyNGBSYUNo9iXa0RMU=
X-Received: by 2002:a05:6512:10cf:b0:5be:5394:162d with SMTP id
 2adb3069b0e04-5bfd954b775mr3148381e87.3.1793657536092; Mon, 02 Nov 2026
 14:12:16 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <20260921-ux500-power-domains-v7-1-v3-15-9352be6b86b1@kernel.org>
 <CAPx+jO_KJJ6ORKuw6VJmtZAOEnzVz0+bq3bEFupAK_4UROKBAA@mail.gmail.com>
In-Reply-To: <CAPx+jO_KJJ6ORKuw6VJmtZAOEnzVz0+bq3bEFupAK_4UROKBAA@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 2 Nov 2026 23:12:04 +0100
X-Gmail-Original-Message-ID: <CAD++jLkC7XehyM3Qh4mDu1zB+_MKhmFn6ae1sA4XCxeS1btT9g@mail.gmail.com>
X-Gm-Features: AclHuK8dNHZsRqLthhksQhjLhAkrSznv9BcaYJhCMzuzVcpQer5tPiLaX8qENy8
Message-ID: <CAD++jLkC7XehyM3Qh4mDu1zB+_MKhmFn6ae1sA4XCxeS1btT9g@mail.gmail.com>
Subject: Re: [PATCH v3 15/18] dmaengine: ste_dma40: Use power domain for LCLA
 SRAM
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Mark Brown <broonie@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Lee Jones <lee@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dmaengine@vger.kernel.org, Frank Li <Frank.li@oss.nxp.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Sep 24, 2026 at 3:27=E2=80=AFPM Ulf Hansson
<ulf.hansson@oss.qualcomm.com> wrote:

> > Hold that domain while DMA transfers are active. The DMA controller is
> > runtime PM IRQ-safe, so keep taking explicit LCLA runtime PM references
> > from the descriptor preparation path instead of relying on a runtime PM
> > device link from the atomic transfer path.
>
> A bit of an orthogonal problem, but related to the above. The irqsafe
> thing have been discussed in the past for DMA controller drivers.
>
> Would it possible to get rid of the irqsafe configuration for the dma
> controller device, altogether?
>
> I don't recall exactly, but not the entire consumer DMA API is allowed
> to be called in atomic context, but perhaps that is not sufficient to
> allow us to drop the irqsafe configuration for the DMA controller
> device?
>
> If not, I wonder if the consumer of the DMA (like an mmc controller)
> should be assigned as a consumer device (using device links and
> DL_FLAG_PM_RUNTIME) of the DMA controller device. In this way, the
> consumer (mmc) would be able to control the supplier (DMA) through the
> device link directly using runtime PM. This could potentially avoid
> the requirement of having to use irqsafe for the DMA controller
> device. Maybe someone already tried this?
>
> If the irqsafe configuration can be dropped, in some way or the other,
> this patch could become less intrusive, as all that would be needed is
> to create a device link to sram device using DL_FLAG_PM_RUNTIME.

I looked at it a bit, talked to the AI prompt a bit, thought about it from
my (limited) understanding and while it seems possible it will need a
substantial amount of work, so I think it's best to get this powerdomain
migration in place first.

Steps to actually go there would include getting proper consumer links
in place and verified, remove all atomic resume runpaths in the
DMAengine, handle requests without a device such as memcpy (I guess
by simply using the DMA device itself as device link?) and some minor
refactorings of lifetime for channel setup/teardown.

But indeed we could use the pretty well documented and supported
U8500 platform as a canary, I think you have access to this platform
too, the upside is that it is "simple" compared to some recent SoC
monsters so it could be an example of how to do stuff.

I don't see much generalizable stuff apart from things like the
pd-patch to the SRAM driver being pretty generic.

Yours,
Linus Walleij

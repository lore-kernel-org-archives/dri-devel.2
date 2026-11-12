Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F6E606A880
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fUCGl2dF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4172910E5EC;
	Thu, 12 Nov 2026 13:02:23 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 518A010E5EC
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 13:02:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CA7B463330
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 13:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0921F00A10
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 13:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794488536;
 bh=VmuMDemC3+M/eObReh66WalmerBYQJEfNi6T5xBgx4Q=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=fUCGl2dFWSGc1o5SOIb84Q5A55k28fIqKGJKoKr/aJ5Am0cn96bC3+8V41fSA3PK4
 MD+A0iOk0TBqGiSXU72vUYCMb/g6DXTqwTtHqnLJbXn+QpeYNeo8RIuXp8TjtS9ixl
 qPF8O7RzTkO0TYq7UkFERDRcZcue3ePOVdxhnVtCZjNIte3xQxTkqtNeinJXoQC3VE
 Ycon9RwQyIf1Won7XlDw7bFfgchO7r3dgHg6P7WXzIBCTV6qMhaWmO/KESdOITf0cO
 Li8uxCaRDOY0GNDGueQJtj5ABrAmb6t82k6otSvTfVC53p+k4WrcpRj0/NNzYYS5MC
 pq4PMaTX67xNA==
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-5c07c7306e1so3688353e87.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 05:02:16 -0800 (PST)
X-Gm-Message-State: APuU4Z8SGqxr4jrIU0Q0PoOQAtEkoFrW3kqCMjEwKkqm7ndRXU2ooZ54
 jOPMoAC0mXbN7VpBKsYVd7kAFYT7hhAClQ33j/nXqZ7NeuHaHC01W7hjKPIAejytV9OYLS6jynr
 1pzMf4/4xGpB1kso50hWjlQOPZUL4EAY=
X-Received: by 2002:a05:6512:1286:b0:5c1:5703:46f4 with SMTP id
 2adb3069b0e04-5c15d58a858mr1893022e87.7.1794488535300; Thu, 12 Nov 2026
 05:02:15 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261108-b4-samsung-s6e63m0-esd-v1-1-ab5c252c9646@kernel.org>
In-Reply-To: <20261108-b4-samsung-s6e63m0-esd-v1-1-ab5c252c9646@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 12 Nov 2026 14:02:03 +0100
X-Gmail-Original-Message-ID: <CAD++jLnfM0gN=v_xWM2uZjcCUCo0rv3-QgVLTGirxdqC00N5bw@mail.gmail.com>
X-Gm-Features: AclHuK_Is6Bfqmku9qYPnPMZqVJRQwYvDrobSZILBCmQKCUAeMXnL1JCTV33yJU
Message-ID: <CAD++jLnfM0gN=v_xWM2uZjcCUCo0rv3-QgVLTGirxdqC00N5bw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: panel: samsung,s6e63m0: Describe
 ESD interrupt
To: devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Bakker <xc-racer2@live.ca>
Cc: dri-devel@lists.freedesktop.org
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 8, 2026 at 1:41=E2=80=AFAM Linus Walleij <linusw@kernel.org> wr=
ote:

> The Samsung Golden device tree wires the panel electrostatic discharge
> (ESD) indication to GPIO82 and names the interrupt "esd". The binding
> does not describe these properties, so CHECK_DTBS=3D1 reports them as
> unexpected.
>
> Describe the optional interrupt and its existing name, and expand ESD
> in the property description.
>
> Signed-off-by: Linus Walleij <linusw@kernel.org>

Patch applied to drm-misc-next.

Yours,
Linus Walleij

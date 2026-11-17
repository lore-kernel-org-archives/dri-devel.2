Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB32606A323
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rRUsEo9A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E771210F72D;
	Tue, 17 Nov 2026 13:26:48 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CDDC10F74A
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:26:42 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6b785ca42ebso7092816a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 05:26:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794922001; cv=none;
 d=google.com; s=arc-20260327;
 b=JWE0MffvjJuSnbx5cXnCKXYudXOLcClxYXVVMd3pTpygxQWaqpNeGgsUSiFkziro1s
 zqon9fA7uhTO2Gw5yP/U9UZTJgnxu6ZpZv8kNEGNlxkRFA+G0MA4W9/DYILr6DsUUiWP
 lyCh/iaFGlU3JCG0C4SPohbY8WQS7xe5Pi+88AxDOoVsbTOCsDxIvj11X83kZJctfmYz
 NironEEtpjwz94ECEMpfe49+f+L3j3+2z+0pSLFw5BG0WMMd4YPMmn+jlGCAMrmMDpjZ
 oE+m1oWzYuu/PrbE2v+E1a1QGVhzLNqg2znn0nG59U1KMZDAP41k/tJxgYCRrwUfSaXl
 Z/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AaDKJsLWEh7/iLpR8aPgnfDX6Rsn+z2sYbKJVVqDKhM=;
 fh=+VYmUK4RToIDlJv+FK/w3B23pzyux9sgm4x+2zfGLjU=;
 b=RcrMSI/lwiaVDYmPuXilkxwGrQPAmZiV9UAbmC+HAYIwQgduUtA8SfiAnYB/FHvNp9
 tuM/LwSqUj/P/hZW8PVZiuHLFqKd6GjbkXTdsRg8DJBuwOZ/Py6ksiWZXIGcXaKv0fAp
 LkxnJ/tuaopE4E697+52egr0tFhQ0ddb8h/SC/wrzU69UJV5FCA9/nqp5MtgYuNs4ZfW
 HarC7RB+zB65Gl1bThIweHzl0qQ7rDd23Q2jMuywBahO4PM+n3rJwbuEeucR0tWOzHhQ
 rt21FxFFtRb0hYywc3eMeq4gGhmdxayVk44AFl30Rg5Ayxn4jlAJb9jTj8PKX/rRGQi+
 Qk/w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794922001; x=1795526801; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AaDKJsLWEh7/iLpR8aPgnfDX6Rsn+z2sYbKJVVqDKhM=;
 b=rRUsEo9APkW6Z6Zias5gxbQLH0QI+Zx2K0RIWDrD2WAGZfMHQWa8dkSxAMcrGkuM0N
 HprhZvrvz1G64LgPO+k2im7lKV8AOa+fLwYi5SGNylh5qYdq1HrI7cCCnrtfQ4nKcFuY
 9E54XGotZC1Ijj1j7RKlryeI1CGTF5C6Lq5o/jhJ7ygBCJw0AGTbiSV6X6SxMN+cqIv+
 PnhFVKdpXFE9/9hbjg+MdHthzL39tobsLVUug2aT+ynHIv894VX76CSm7BUut5opRfdZ
 woXHgckk1gB1qdCw+Un2khWof77MSdEhXjF2vGQzwSTSbiuzTT2Xdr1XjOQhD76pWcQi
 KidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794922001; x=1795526801;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AaDKJsLWEh7/iLpR8aPgnfDX6Rsn+z2sYbKJVVqDKhM=;
 b=Ht7m0uYQDYnEMO3yFC0w9puC15N9kjepOXfLVkkyEOVmFnpn7Xd4luJY9CqAxYZejQ
 AZYlYaSOPtdJx/Nw/TnO9Q4Ofk1svUg+ESvbpvp9nEK/2o3/fdNUKs6+2upH6d3ppYei
 vEc6GsO+91B49/WjjuuS9UUsLAyzVPgy7hvfRzz6cJ66ASG0I6GVI6rb9ge3/nIkiDu4
 l70y24yDJRt6m7sIYJJw2XPwkMgIeXNF7T9+KiUyyjoA1ZSDs/THo8qKZyNP6p/qGGR4
 kzd0w3ZRPcDl2kTe5t+ZNUuAi00CqzTjJlZ79z1ENcuqeFVA/n545xxevra7D3PTqAm1
 OFrg==
X-Forwarded-Encrypted: i=1;
 AL+hErEiuD+vIsjkCnj1Qpnq/TW2g1dDqhS6kaY6G6CNRwWgX8qc2L8W8wegfikzrej/Gu/WRMUJbbz0R7A=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8kkpnMBq9IFCnRGN9AiEtcsjahWjMNMb3M2p2+2Vjtpd/7EvI2
 OwboQHKDxq2OEnxG1f7CcPQa4rHsntuXkxaNxwf+8WBtSXZwPtZSVs8rqHTlBvKilDinswQpHva
 SEGh6I2NcqySb9B/a9AoAD18ihYzvLCY=
X-Gm-Gg: AYBFou3u391ZHLj3ceicW8isgrVNZoeK1QTuAi7bVDr8IGU/SZmyIo1wTRG6hcF7SUT
 Q47lYrj22StDG1B27YuxcB5NOqGs6w9SyipeC5JrRfqCAgJE2lJfvcciO+n2S/fQxvSWn4Za16h
 Vc+bYIxsiMcoV2P1R95zyuddcXwOY6AEukmnKoROYjsvjYCYrWbeqJ8q6dEYazDs9zkT/L764eV
 78yvoycf27fn6ITK1mK+EVeXJAEB2AXvQ7SedQ47G/sS69Wr4d5xbLK5x9RxmawWV412w7u5ulo
 lcrgUL6Hg75uh8EaFsM9hXUwWkD3Swjwkgvo9FK3fIFZ+bPTE7BOzdK23mJ6vT8cV2YFojKQWQ4
 agD+FEmGn0581NH5ze1aWNrEPA+KaUDAY1Qo=
X-Received: by 2002:a05:6402:4504:b0:6b5:7de8:87cd with SMTP id
 4fb4d7f45d1cf-6b7c0d06f9amr10641554a12.42.1794922000158; Tue, 17 Nov 2026
 05:26:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260921113914.779393-1-l.scorcia@gmail.com>
 <20260921113914.779393-2-l.scorcia@gmail.com>
 <3701981f-cdda-46a7-8079-de5479ae9c27@kernel.org>
In-Reply-To: <3701981f-cdda-46a7-8079-de5479ae9c27@kernel.org>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Tue, 17 Nov 2026 14:26:28 +0100
X-Gm-Features: AclHuK-pAjMxUsyMno9u008purn-se7dqQHzpp18oe2HOK5CuVKhIbMUqhDzQWQ
Message-ID: <CAORyz2+wF=VDTFkRFU7jBu-zNTW7T8mnPrJZAj8ZVD-Yyr2b6A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: display: mediatek: dpi: Add
 compatible for mt8167
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-mediatek@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, CK Hu <ck.hu@mediatek.com>, 
 Jitao shi <jitao.shi@mediatek.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Turns out you bring here undocumented ABI. NAK.

Hi, I'm sorry but I don't see the relation between this commit you
just NAKed and the bigger issue about mediatek-drm alias usage. It's
not like I'm introducing anything new in these DPI specific patches
and the individual display block drivers do not depend on the aliases
(they're used by mediatek-drm for building the pipeline).

I understand why the commit to the dtsi that includes the aliases is
NAKed, and the eventual fix is going to require a change in all of
Mediatek SoCs dtsi. I am fine with the dtsi changes being blocked
until an appropriate solution is found. I just don't understand the
NAKs on the DPI components.

Thank you for your help
--
Luca Leonardo Scorcia
l.scorcia@gmail.com

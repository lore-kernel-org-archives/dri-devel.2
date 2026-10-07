Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981ADCA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:21:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F01AB10F62C;
	Wed,  7 Oct 2026 14:21:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="W5JnlO6J";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-90.mta0.migadu.com [91.218.175.90])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C35410F646
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 14:21:52 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=WRUDCI6omUSsIZ8s+gMFBUC/otSE4gNpcSilBRiqh3E=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791382910; v=1; x=1791987710;
 b=W5JnlO6JkeMkoUEcCiuDwAoz0InWi3QMnNOD7RLCgIyWo/Xnjs9WpfXWq6vZ6eqPwk47fV8E
 IvXsIrgpWFQJ+sXLMxwqD9geavZJlcvipajE0Q7xv0Ev9G/mBrXdVhJ4gly7BtG49KWiW6QL8Nz
 0QrDLuuZUkENv6mq+0wOw4as=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by mta10.migadu.com with ESMTPS id 8aed19a99e5f9cba;
 Wed, 07 Oct 2026 14:21:49 +0000
X-Mizu-Trace-ID: 8aed19a99e5f9cba
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Aditya Garg <aditya.garg@linux.dev>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] drm/appletbdrm: Fix incorrect error message on encoder
 attach failure
Message-Id: <7737F93E-AAAA-44EE-88EB-B4C3F48ED798@linux.dev>
Date: Wed, 7 Oct 2026 19:51:38 +0530
Cc: Aun-Ali Zaidi <admin@kodeit.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Atharva Tiwari <evepolonium@gmail.com>,
 Kerem Karabay <kekrby@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Adam Azuddin <azuddinadam@gmail.com>
To: azuddinadam@gmail.com
X-Mailer: iPad Mail (24A446)
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

=EF=BB=BF

> On 28 Sep 2026, at 2:04=E2=80=AFPM, Aditya Garg <aditya.garg@linux.dev> wr=
ote:
>=20
> =EF=BB=BF
>=20
>> On 26 Sep 2026, at 6:49=E2=80=AFPM, Adam Azuddin via B4 Relay <devnull+az=
uddinadam.gmail.com@kernel.org> wrote:
>> =EF=BB=BFFrom: Adam Azuddin <azuddinadam@gmail.com>
>> drm_connector_attach_encoder() replaced an earlier call to
>> drm_simple_display_pipe_init() during review, but the error message
>> logged on failure was not updated to match and still refers to the
>> old call.
>> Fixes: 0670c2f56e45 ("drm/tiny: add driver for Apple Touch Bars in x86 Ma=
cs")
>> Signed-off-by: Adam Azuddin <azuddinadam@gmail.com>
>=20
> Reviewed-by: Aditya Garg <aditya.garg@linux.dev>

Could anyone please merge this? Thanks.=

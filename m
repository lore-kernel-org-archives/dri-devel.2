Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989E2CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:21:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6E9010E323;
	Wed,  7 Oct 2026 14:21:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="a23dhS7l";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-87.mta0.migadu.com [91.218.175.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 696AD10E323
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 14:21:44 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=UUIoMs93rODwFtQnIT3OzAP7gYQZke3OsGqiubGoUz4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791382901; v=1; x=1791987701;
 b=a23dhS7lE78kaW4F+Z9RDN8ub1/Sx0bAFDbO1ty4OOQIe1wxvIsTacTzf5l0WCY5UDlQDO5f
 O/ENC1IH2LWT+etuSmyaETPcPIyL14deKd2Mnw3logRJicnSotxQP4gpwASJEtyZ+2cGQZJtMJ4
 gcG8Y7psJBzPAPtyhmdNZscA=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by mta10.migadu.com with ESMTPS id 27bc66e47057acb3;
 Wed, 07 Oct 2026 14:21:41 +0000
X-Mizu-Trace-ID: 27bc66e47057acb3
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Aditya Garg <aditya.garg@linux.dev>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] drm/appletbdrm: Fix incorrect error message on encoder
 attach failure
Date: Wed, 7 Oct 2026 19:51:12 +0530
Message-Id: <6EAF4657-AAF7-447E-8434-D0E0D647B691@linux.dev>
References: <F9EEFFBD-A749-4374-9FF4-75917ED2D204@linux.dev>
Cc: Aun-Ali Zaidi <admin@kodeit.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Atharva Tiwari <evepolonium@gmail.com>,
 Kerem Karabay <kekrby@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Adam Azuddin <azuddinadam@gmail.com>
In-Reply-To: <F9EEFFBD-A749-4374-9FF4-75917ED2D204@linux.dev>
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



> On 28 Sep 2026, at 2:04=E2=80=AFPM, Aditya Garg <aditya.garg@linux.dev> wr=
ote:
>=20
> =EF=BB=BF
>=20
>> On 26 Sep 2026, at 6:49=E2=80=AFPM, Adam Azuddin via B4 Relay <devnull+az=
uddinadam.gmail.com@kernel.org> wrote:
>>=20
>> =EF=BB=BFFrom: Adam Azuddin <azuddinadam@gmail.com>
>>=20
>> drm_connector_attach_encoder() replaced an earlier call to
>> drm_simple_display_pipe_init() during review, but the error message
>> logged on failure was not updated to match and still refers to the
>> old call.
>>=20
>> Fixes: 0670c2f56e45 ("drm/tiny: add driver for Apple Touch Bars in x86 Ma=
cs")
>> Signed-off-by: Adam Azuddin <azuddinadam@gmail.com>
>=20
> Reviewed-by: Aditya Garg <aditya.garg@linux.dev>

Could anyone please merge this? Thanks.=

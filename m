Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1122FCCA464
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 10:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AC1610E288;
	Fri, 16 Oct 2026 10:23:23 +0000 (UTC)
Received: from mta0.migadu.com (out-41.mta0.migadu.com [91.218.175.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 919C210E288
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 10:23:16 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=+DbsR2QGNazTX5aTT3V2iqIn/ew54sS/4tG7fp2Z4sM=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792146194; v=1; x=1792750994;
 b=do7g0FXA0FvHxKGrXRSSW7vDOn3scZrxdfNLEa4HlIRB3Y0uE80kQy9OKgpDfRSdnT/LXHDk
 6VuKPUdG9OLdKnbjux183nbxAiYkleFoC44K3CQUXe80tI7OxIRGjlSkCvx7Wv5L9B+1kR7Hlh8
 bfaoDKlLnYt+7FtbNhmh1WpY=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by mta12.migadu.com with ESMTPS id 236b526ee2bc9499;
 Fri, 16 Oct 2026 10:22:10 +0000
X-Mizu-Trace-ID: 236b526ee2bc9499
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Aditya Garg <aditya.garg@linux.dev>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] drm/appletbdrm: Fix incorrect error message on encoder
 attach failure
Date: Fri, 16 Oct 2026 15:51:56 +0530
Message-Id: <7FF6CD32-8BFE-4DF9-8FB7-53BD9A5190F1@linux.dev>
References: <F9EEFFBD-A749-4374-9FF4-75917ED2D204@linux.dev>
Cc: Aun-Ali Zaidi <admin@kodeit.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Atharva Tiwari <evepolonium@gmail.com>,
 Kerem Karabay <kekrby@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Adam Azuddin <azuddinadam@gmail.com>,
 Lukas Wunner <lukas@wunner.de>
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

Lukas since you seem to be having write access to DRM tree, pls merge this t=
oo. Thanks.=

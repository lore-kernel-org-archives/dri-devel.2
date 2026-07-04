Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6858C43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 22:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DA5B10E0EF;
	Sat,  4 Jul 2026 22:24:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=rcpassos.me header.i=@rcpassos.me header.b="JvYKahFc";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="FiD2rMg3";
	dkim-atps=neutral
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C98610E0EF
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 22:24:31 +0000 (UTC)
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256;
 b=JvYKahFcQ5vBELyB2vY1Gd1nu6kySDhRVslialNKMEtfZNAoemYK993eFgxYxDjZT3P8hURkoCJyzflLfsYcAy4PQWvFoR36K7r6j8ViIlj0AI1dQDTeiZYz4TjSTklf1t9g04QH+pXxBQtkXFsM6bCcT0lV2ZzXkVEcsQeh+yzkA7wFNwwh1MW9IH7v1pO/WdhsBhHD/s0M7UiApDrY3T5M3CQSL1j8lLNQXhe7HVbkNKpQbzX6Z9laKgb/+bFbNT56vLm9swxpiRqZEV9fiduzdqeKl4Oq4kEBittJlZqd4EPT/+BvBaUA6qw+0zO4/WSAghyt7T+pI8Ic9WDazQ==;
 s=purelymail3; d=rcpassos.me; v=1;
 bh=Hwtx7M7RsIPIAUmf8VDxcdSeGvoyG9CqwzMLKzUDnvI=;
 h=Received:Date:Subject:From:To; 
DKIM-Signature: a=rsa-sha256;
 b=FiD2rMg3lOw43KSAARoh175UELiqsqL4ymaRiY42/sRcYfivvRmLcW+h+ku5NmXdhKqqZANnH6PiOO0d7aZdBNzKIRIxuFwfRaPsEybdaMhR0jAvMdxLSLqOlXaA0UJTokQSfvY5GlAQ565X/z0liZDjbIMHdM7ZmQNcYGV9UjvAxurM0PAYtjXGu+bH2ZSWcv6yhWo/lpslTGyBrl4CaHNeCEkfYDsOPNIoXRCLEh85fXdtOujkaYFW+xUyuZGk/TaYHoxeBamb6fWKvbeXY7lEXit0Uk9/UuBKwb7HvuOrdJOmI9v+MMfS8Nll7KOcFSYn1sPB6JzQLg0Gx4ctqg==;
 s=purelymail3; d=purelymail.com; v=1;
 bh=Hwtx7M7RsIPIAUmf8VDxcdSeGvoyG9CqwzMLKzUDnvI=;
 h=Feedback-ID:Received:Date:Subject:From:To; 
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: dri-devel@lists.freedesktop.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 498733413; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 04 Jul 2026 22:23:51 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Jul 2026 19:23:37 -0300
Message-Id: <DJQ4ZWJK3ONU.I3SGSXM44M1S@rcpassos.me>
Subject: Re: [PATCH RESEND v2] Documentation: xe_drm: fix chars used for
 subsection
Cc: <matthew.brost@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, "Randy Dunlap" <rdunlap@infradead.org>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
From: "Rafael Passos" <rafael@rcpassos.me>
To: "Rodrigo Vivi" <rodrigo.vivi@intel.com>, "Rafael Passos"
 <rafael@rcpassos.me>
X-Mailer: aerc 0.21.0
References: <20260701012141.167868-1-rafael@rcpassos.me>
 <akgBC8A9h8nIyEYd@intel.com>
In-Reply-To: <akgBC8A9h8nIyEYd@intel.com>
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

On Fri Jul 3, 2026 at 3:35 PM -03, Rodrigo Vivi wrote:
> On Tue, Jun 30, 2026 at 10:20:58PM -0300, Rafael Passos wrote:
>> In case it helps, here are the tags Randy added in my first send:
>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>
> Next time, please put these directly above the '---' along with your sign=
-off.
> And please use the standard 'drm/xe:' tag in the subject.
>
> I modified the subject and pushed it to drm-xe-next. Thanks for the patch=
.

Thank you for poiting out these improvements Rodrigo.

I'm always learning more :)

Rafael Passos

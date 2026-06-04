Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A911CD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B21FD11A309;
	Thu,  4 Jun 2026 20:45:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=mark.filion@collabora.com header.b="c6RO4DVB";
	dkim-atps=neutral
X-Greylist: delayed 903 seconds by postgrey-1.36 at gabe;
 Thu, 04 Jun 2026 20:45:15 UTC
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com
 [136.143.188.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2459D1134BB
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:45:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780605011; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GFsCicHQxHAv3KTZ1sVxj6HGeDzOklkal2YeH0qN0AVZh5RnzUbj5IyulLLvKDVOWnyMzc5b5p9ykgYc2DkO55r2pfatXdvI5/S+ZaEdWU4gEmtSBJpM2zjJFxEbt84jbPb+7oQ/uzcYS/LfEDOm7Aip7x+qCZbd/6/2pZI8A8A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780605011;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=muC6rawBX3CykhRdzS4yBFWa650rEAb1z3ELNMgRXrs=; 
 b=HzcvcMy766XRMg49ZtjOv8+QgPlNEe5JlRG6Q6Il/OMFK8PGvMoeTsuzKz8/kZrie7hrk4N9UAWJSn9l2akmBqqums9ToB/eaxq31boADaTHVqfo7uV0zkeWYcmE4sZOP4mmoAUfr+JRlKo5ASivcn2QwMlTcx0q3+Uz/65NUpY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=mark.filion@collabora.com;
 dmarc=pass header.from=<mark.filion@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780605011; 
 s=zohomail; d=collabora.com; i=mark.filion@collabora.com;
 h=Message-ID:Subject:Subject:From:From:To:To:Date:Date:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To:Cc;
 bh=muC6rawBX3CykhRdzS4yBFWa650rEAb1z3ELNMgRXrs=;
 b=c6RO4DVBfsRSQMYGHCw2POCnXSfhsKPE9IoQwhIp3kqcCvvFCKqNDOYPbDITs79t
 cZ2BuDHKj6NZsxhGh7iZ006PtLmejUT0ORtpa+89VVjuzKqVLSGFf2UeU2tH4HpILgo
 W/xs9bUKDOJnQdnT00J7vS9jI5R8sWQ+ZvHuK/G4=
Received: by mx.zohomail.com with SMTPS id 1780605008914375.88079836560087;
 Thu, 4 Jun 2026 13:30:08 -0700 (PDT)
Message-ID: <9532af4a167cd029f0cd88176ff2e6982517a3d7.camel@collabora.com>
Subject: XDC 2026: Registration & Call for Proposals now open!
From: Mark Filion <mark.filion@collabora.com>
To: dri-devel@lists.freedesktop.org
Date: Thu, 04 Jun 2026 16:30:08 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44app2) 
MIME-Version: 1.0
X-ZohoMailClient: External
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

Hello!

Registration and Call for Proposals are now open for XDC 2026,
taking place at the Daniels Spectrum in Toronto, Canada,
September 28=E2=80=9330, organized by Arm.

    https://xdc2026.x.org
=20
As usual, the conference is free of charge and open to the general
public. If you plan on attending, please make sure to register as early
as possible:

    https://indico.freedesktop.org/event/12/registrations/

In addition to registration, the CfP is now open for talks, demos, and
workshops at XDC 2026. While any serious proposal will be carefully
considered, topics of interest to X.Org and freedesktop.org developers
are encouraged. The program focus is on new development, ongoing
challenges and anything else that will spark discussions among
attendees in the hallway track.

We are open to talks across all layers of the graphics stack, from the
kernel to desktop environments / graphical applications and about how
to make things better for the developers who build them. Head to the
CfP page to learn more:

    https://indico.freedesktop.org/event/12/abstracts/

The deadline for submissions Friday, July 3, 2026.

We are looking forward to seeing you in Toronto! If you have any
questions, please email the organizer (charlie.dixon at arm.com), and
CC=20
the X.Org board (board at foundation.x.org).

Don't forget, you can follow us on Mastodon for all the latest
updates and to stay connected:

    https://floss.social/@XOrgDevConf

Best,

Mark

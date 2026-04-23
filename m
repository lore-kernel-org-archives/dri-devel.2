Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD69FAD3E6
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 00:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A40DD10EA43;
	Thu, 23 Apr 2026 00:53:04 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [207.211.30.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6810910EABE
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 00:53:03 +0000 (UTC)
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-WlvI2kkfMdC2OwfZqhq63Q-1; Wed,
 22 Apr 2026 20:45:59 -0400
X-MC-Unique: WlvI2kkfMdC2OwfZqhq63Q-1
X-Mimecast-MFC-AGG-ID: WlvI2kkfMdC2OwfZqhq63Q_1776905158
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 974EE195608B; Thu, 23 Apr 2026 00:45:58 +0000 (UTC)
Received: from dreadlord.taild9177d.ts.net (unknown [10.67.32.53])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 932CA30001A1; Thu, 23 Apr 2026 00:45:56 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Subject: nouveau: add HDMI FRL support for GSP enabled GPUs
Date: Thu, 23 Apr 2026 10:42:12 +1000
Message-ID: <20260423004552.3289884-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WjoWck4JzshKfLzvMB5gzEMrouZOt5Vtw1m2MtXPm1Q_1776905158
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true
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

This adds higher refresh and resolution modes that need FRL support
on HDMI.

With GSP the firmware handles most of the hard work, just need to
send things in the correct order and handle the link training at the
right points.

The first commit reorders current SCDC support on GSP to do things
in the same order as NVIDIA open driver. Then it builds on that to add
FRL pieces in the backend, and the final patch adds all the frontend
pieces.

I've tested this on Ampere GA106 + a HDMI 2.1 capture card (Elgato X).

I used claude code to iterate on this a bunch to solve the ordering
issues and align with NVIDIA programming sequences.

Dave.


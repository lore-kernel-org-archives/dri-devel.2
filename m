Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F36C624D0
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4333510E32E;
	Tue,  1 Sep 2026 19:56:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=mark.filion@collabora.com header.b="J4TM5lRJ";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3502310E32E
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 19:56:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788292598; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JhtMARlHFmmkstXDegyaNv0jcCXzzVlTvFF46IODmSOIJyZ0ZDZn2AneZpHJtAscidVXAMCXn9qbKkgflhVhXERp1wz579n+/XG+BtPffvLt6CJ6GXMSMWqN6maKhX42o4z478EI+x+2T0Vxj6wUi/FIyRsyKPu8DpLPozoTUBA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788292598;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=/qHEHJKZk4x+utXQVy6Oy+Uc44nyD4jHGrqzfQUFDl4=; 
 b=nNLVUctWNKCqTgKtzMYoBibQyY1gmHriE0R4KRRzCK8VO+dgYhZo+PyQN/Pz4U8tkyvsFc5zdTHB5u4ENQ3pQwp+IjnPVW+UMpnveAIg+BNjLErycOWy5lNBUICxKaRYVPH6FX+Zo8lzSDMlc5sILfZ+o3qGGhLxUanOyIvpl3Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=mark.filion@collabora.com;
 dmarc=pass header.from=<mark.filion@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788292598; 
 s=zohomail; d=collabora.com; i=mark.filion@collabora.com;
 h=Message-ID:Subject:Subject:From:From:To:To:Date:Date:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To:Cc;
 bh=/qHEHJKZk4x+utXQVy6Oy+Uc44nyD4jHGrqzfQUFDl4=;
 b=J4TM5lRJ+7PDo9kcGQPmuR1gUkUZ39fVuUHOBmcEWBHYAhRawu+pmQ7COIrQhOQS
 nTVV0NENdqxBGsl4szNjhBMJZHkRZLNj/z4SF/qSpw2IICc7arOa4iHxG4TdV5KP13y
 1hjvTFVrUYtRywNNVm4Q3H1jQhBt5qFh+N+5qGGk=
Received: by mx.zohomail.com with SMTPS id 1788292595282758.083338318131;
 Tue, 1 Sep 2026 12:56:35 -0700 (PDT)
Message-ID: <67e40a640f5d7de8802c7fa21afebd0d127bd5d6.camel@collabora.com>
Subject: XDC 2026: Full schedule now available
From: Mark Filion <mark.filion@collabora.com>
To: dri-devel@lists.freedesktop.org
Date: Tue, 01 Sep 2026 15:56:33 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44app2) 
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

Hello everyone,

Only a few weeks to go before XDC 2026 kicks off in Toronto, Canada!

The full schedule of talks is now available! Check out the schedule to
start planning which talks you don't want to miss.

https://xdc2026.x.org

The CfP has also reopened for Lightning Talks, Workshops, Meetings &
Hacking Sessions. Submissions are welcome, though acceptance is subject
to available time in the schedule.

https://indico.freedesktop.org/event/12/abstracts/

If you are planning to attend, please make sure to register.
Registration is free, and helps us plan for catering, evening events,
and nametags.

https://indico.freedesktop.org/event/12/registrations/

Best,

Mark

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FA5C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 20:28:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AAF010ED3C;
	Tue, 30 Jun 2026 20:28:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=mark.filion@collabora.com header.b="hDkJ7NDP";
	dkim-atps=neutral
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com
 [136.143.188.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D11210E258
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 20:28:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782851296; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gf1VlwcwRWWiEnsmQxQtf0fObsfP61Pj9TP9cNVg+eoFp76qCebO78hP3ntoBKcyEVaW60j2Yr0FbYIWB5iC127M4clnmsLCGtHeeoiiYpiKh87jBqkSQmyutRm20+7rE1aIjWVDM58jzwI5737YH+p11UxWldij8Cp5x7jiiVA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782851296;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=/xxStwIF61bn3ZqA6+M8xNVE8MJdolxYpTE31ogRu80=; 
 b=U+y+Y8JNztHz6TU0ZIFHslaBWm+fIK7AtsFkKTlJGq8dtCz62QginpyHE8kUFGNmqAHbreAYv8Po0TxjGMtipstN3XTtIJzae/Cu1vfItWaegs+k7fWS/C2tauH5dWfaqJpmYtZ0SSki0GcCjsDapOoc0zIHBb8j7WVc0AGaV5w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=mark.filion@collabora.com;
 dmarc=pass header.from=<mark.filion@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782851296; 
 s=zohomail; d=collabora.com; i=mark.filion@collabora.com;
 h=Message-ID:Subject:Subject:From:From:To:To:Date:Date:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To:Cc;
 bh=/xxStwIF61bn3ZqA6+M8xNVE8MJdolxYpTE31ogRu80=;
 b=hDkJ7NDPQt854wNiNBmBC/IdWCBXr+odeXcAn4ERWY2zw5gVTpjQrhfL3HMlxLTH
 tak1H611kWzf5B1KYjqXXLUaHlOkPXeUyQ9EaVDzHmswWZKvBovzUZDtElacGF8blfo
 HkdZ3oyxTaHFDBbF0tuQh0efQqQyy6qGWaB4qM7k=
Received: by mx.zohomail.com with SMTPS id 1782851293849807.4045988828807;
 Tue, 30 Jun 2026 13:28:13 -0700 (PDT)
Message-ID: <1a8c811a419c4ae0c96a47df86cfbde32719b168.camel@collabora.com>
Subject: Reminder: Call for Proposals closing soon for XDC 2026!
From: Mark Filion <mark.filion@collabora.com>
To: dri-devel@lists.freedesktop.org
Date: Tue, 30 Jun 2026 16:28:13 -0400
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

Hello!

Reminder - The deadline for submissions for XDC 2026 is this coming
Friday, 3 July 2026.

    https://xdc2026.x.org

While any serious proposal will be gratefully considered, topics of
interest to X.Org and freedesktop.org developers are encouraged. The
program focus is on new development, ongoing challenges and anything
else that will spark discussions among attendees in the hallway track.

We are open to talks across all layers of the graphics stack, from the
kernel to desktop environments / graphical applications and about how
to make things better for the developers who build them. Head to the
CfP page to learn more!
 =20
As usual, the conference is free of charge and open to the general
public. If you plan on attending, please make sure to register as early
as possible!

Best,

Mark

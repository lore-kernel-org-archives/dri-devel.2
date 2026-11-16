Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F1B606A330
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=zohomail.in header.i=@zohomail.in header.a=rsa-sha256 header.s=zoho header.b=nIizi3eZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 067ED10EEA9;
	Tue, 17 Nov 2026 08:08:26 +0000 (UTC)
Received: from sender-pp-o91.zoho.in (sender-pp-o91.zoho.in [103.117.158.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A7F310F432;
 Mon, 16 Nov 2026 20:17:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1794860253; cv=none; d=zohomail.in; s=zohoarc; 
 b=Qf4mdUrHCEhVFBJsuCmqp+3BO2XTYQ+8+rfhG8bcZokP5FtDlesum8C4mKxYsD8VAp/RTClJE+kbyEE2sf6JY4TWAI72eFddk6yXaOp5xLaGCg1lTlDc7FdCzJ7EtmYPeMBKjoBqs0nrrysZGuC+5SJP59F0obBcjFtUPRgX+sw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in;
 s=zohoarc; t=1794860253;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=xr+vU2Zqa/z93J8db0TarH/417S2TioNRzo32FWgIQY=; 
 b=QihpJMzrTsa8sj0xphg8hXnpFjDi3xkish56eBG/RUvnpDBYmD92YiAoirf06hcJufNOaMgOlib1gVxFCH+2OJFgYNFzpyRSVexXGv6HSM8EN5OmcILHE/Bh7c4/AGr2CmB+8t0dcMFXOMLBECoUFatJU7nf7vrwLv5hcVNdBog=
ARC-Authentication-Results: i=1; mx.zohomail.in;
 dkim=pass  header.i=zohomail.in;
 spf=pass  smtp.mailfrom=shivamkalra98@zohomail.in;
 dmarc=pass header.from=<shivamkalra98@zohomail.in>
DKIM-Signature: a=rsa-sha256;
 b=nIizi3eZ2DcGoxK8k+jRLdTqWDQzzD8Glb9m0F0jIPGhDLIKQuwalRjV+6Zeu4LenrjBUk1tyjElOgxu260Pw2GLvY47GW1PEfaHVHBSzedZqZS/b1ZNlvfZ98fflidee7p6V1eln6bdktFXvGJRM0SK2YG//sXudox0SuLt0oQ=;
 c=relaxed/relaxed; s=zoho; d=zohomail.in; v=1;
 bh=xr+vU2Zqa/z93J8db0TarH/417S2TioNRzo32FWgIQY=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.in with SMTPS id 1794860251599240.5767861719902;
 Tue, 17 Nov 2026 01:47:31 +0530 (IST)
Message-ID: <39ecbbd3-8ff1-4040-9d93-1ee74dfecd69@zohomail.in>
Date: Tue, 17 Nov 2026 01:47:30 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: use atomic commit for panel power
 savings
To: Hugo Sales <hugo@hsal.es>, "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, David Weber <weber.aulendorf@gmail.com>,
 Alex Hung <alex.hung@amd.com>
References: <20261111-abm-sysfs-atomic-v2-1-6dfb19c51ebe@zohomail.in>
 <ffbea2f6-c2d1-4e61-9e58-fc458d7abf0d@amd.com>
 <1629832733.648780.1794838345723@app.mailbox.org>
Content-Language: en-US
From: Shivam Kalra <shivamkalra98@zohomail.in>
In-Reply-To: <1629832733.648780.1794838345723@app.mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 17 Nov 2026 08:07:18 +0000
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
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 16/11/26 19:42, Hugo Sales wrote:
> Shivam, v3 of "Commit panel_power_savings writes from the kernel"
> replaces the v2 Chenyu linked:
> https://lore.kernel.org/r/20261116-abm-sysfs-commit-v3-0-7a3d84a5328e@hsal.es
> 
> It adds a fix for an overlay plane dropped while VRR is active, so
> please test it on top of "Leave self-refresh before an ABM level
> update" v2
> 
> Hugo
Thanks for the update, I'll take a look.

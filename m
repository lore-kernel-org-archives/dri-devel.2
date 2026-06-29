Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B056C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81E7610E839;
	Mon, 29 Jun 2026 11:58:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="Sw94lzUy";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D293810E839
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 11:58:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782734288; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VFYq+wU4bkeByeOlKmO20qgDA8Rbri7AemD3CctH6euN9MXNZiRmawZfmg2SydnACgkYQp1kVc6UiCaEn4NcXAFbTyy7Tx0oU+8s0cXyCsU7extPpX3wa0zVNebJYmtIehg7nwg5UYF9bQOp2crp1v+h7SbvALG3Zvnc+ppeF6w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782734288;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=iUAj9nhCCaaOFb7421g6sg9FUGL5L6QYCWEFIc2pzo4=; 
 b=KJlrgT8JU/7RVPMvq/Vy1W1WiN0IaQkmfg/uCFCheVNQ9wQtG0l0CFBFtD5UY5T0QPMP7qxzs/jvaP+2RM0qC2Oo/6zcihLyjCsF6vAHstMdhAKe0TI5xJa07Jh1i6pgL5o+9KRg8KQOLEHV9Xvm8vQPxbf+6o2Z8PANYpsm+B0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782734288; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=iUAj9nhCCaaOFb7421g6sg9FUGL5L6QYCWEFIc2pzo4=;
 b=Sw94lzUyb0Q37iEbY7XILIy3JhBG+NdbiEAJqPpW4lejUwuHggM2I+9HAzVsUJQD
 hXMolxZ15GODHj8YJGEO/0woLKzRMmBP+XHRKH3332CzcVP/uHQCCJOa7S1AU8vvuPi
 +H+9yhs+0ekVmUgm7fiBxocevL8yba/H/WY79ZP0=
Received: by mx.zohomail.com with SMTPS id 1782734286080377.50934110595267;
 Mon, 29 Jun 2026 04:58:06 -0700 (PDT)
Message-ID: <0a444d8c-6107-4577-bed3-0039333a5244@collabora.com>
Date: Mon, 29 Jun 2026 13:58:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] udmabuf: Ensure to perform cache synchronisation in
 begin_cpu_udmabuf()
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
Cc: dri-devel@lists.freedesktop.org
References: <20260627105725.9083-1-robert.mader@collabora.com>
 <CABXGCsPHdi3=Tpg2uZhZMuLNmg8r9Bg=OgD39eyMc=pv8gc_TQ@mail.gmail.com>
 <bc41095d-8956-4c3e-8f99-f4bda41f81e7@collabora.com>
 <CABXGCsNYEhkprpTh9Pd8Y46520fwNJngS_Bg_QJCQPCf3_qv0g@mail.gmail.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <CABXGCsNYEhkprpTh9Pd8Y46520fwNJngS_Bg_QJCQPCf3_qv0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 29.06.26 13:48, Mikhail Gavrilov wrote:
> On Mon, Jun 29, 2026 at 3:57 PM Robert Mader <robert.mader@collabora.com> wrote:
>> Hi Mikhail,
>>
>> thanks for the quick review! And no worries, I was very happy about your
>> patch, which is why I looked deeper into it in the first place.
>>
>> Given the patch fixes a newly introduced regression (and is very
>> simple), do you think there's a chance to still get it into 7.1 - or
>> would it need to go via the usual 7.2/7.3 release schedule + backport?
> Hi Robert,
>
> The timing depends on Vivek and the drm-misc maintainers, not me,
> but here's the situation as I understand it:
>
> The original commit 504e2b4ab97a only landed in 7.2 (it went into
> drm-misc-next, not drm-misc-fixes). So 7.1 was never affected by
> the regression -- there's nothing to fix there.
>
> For 7.2: since your patch fixes a regression introduced in the same
> cycle, it would ideally go through drm-misc-fixes to land in 7.2
> before release, avoiding a broken commit in the final tree. That's
> the cleanest outcome.
>
> Adding Vivek -- he pushed the original patch and would know whether
> drm-misc-fixes is the right route at this point in the cycle.
Hi Mikhail, I of course meant 7.2, not 7.1, sorry! And agreed, that 
would be ideal / perfect.

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718


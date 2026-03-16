Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2FAF3028B
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 04:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E81710E2BA;
	Mon, 16 Mar 2026 04:05:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="T0Myu32v";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D5210E2B7;
 Mon, 16 Mar 2026 04:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773633932; x=1805169932;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=SF38I8zQuyvko6pJUugdueo/eYScsz4e36r533Q0Msg=;
 b=T0Myu32v7P2HAmobvK3+/IYXLYk7gwkqFW9L7tG+MDkBqxNH/g63kOTB
 RE1HrMRNKfmvM2LXD4VBC7lsDYlL6wzO3E5yjhYhDV0l6wK3rOzD4whrF
 r303tjV1PaVHJMsK1ImfK+4lZ8U+8cTs8ZW9iYEck7LbLfZDzqCTfCVBO
 hdVDwr/fMeP8/83+RxhUc1flNh9AVeV9ASNa5fNAvGCXKYKY9U7HsWz1Q
 EsGDvS8V/F/apMZ10W5N/EIq+5pTJXxyAGlglQFf+PA6e7WcEYfFquXLE
 NVqw5z6gh4b9cyiG8spfqjB/Qlnp4dpGfrpPIs9sggpmvor05me5RYNVn A==;
X-CSE-ConnectionGUID: D0WGVy0HQ+SHVQs7b/mZUw==
X-CSE-MsgGUID: 2lDhH53QS+eesXvnTdA7OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74618811"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="74618811"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:05:32 -0700
X-CSE-ConnectionGUID: spuELeGeRMaFkMWuRTyHkA==
X-CSE-MsgGUID: vZmZXxMkS7WySYYcx3b6vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="244827207"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:05:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 15 Mar 2026 21:05:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 15 Mar 2026 21:05:29 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.69) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 15 Mar 2026 21:05:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtJpGrRvEdR2rz3JLfvRPWyMqBnSHntdN7qkUFgqYYVd2E4OufmWuKurOmm8ufPXZPmqNSaz+w0P1YXmkZ8dTevlFlfOv4qemPGV3aJbto5H/QDFaG748QpB3nITG+45woTVZLjMawxYPoxp07x/5drf+ByvqECcthI5tv32EB67MeFaGZ9OBvH8joo/CM79Prh+G0Fgc4k5862LMa+jWKMwwgs7ViEWtwdlg3FiUol49TyrDJJRLeWC93fb/XFwlEYyCUtKw4AjPmub+dzy2Qnqc3y0DAe6bQr256gR1XIHidQTcK00wzBxZkOf/YwdQCAU4TFMmRjpusBHHLiLag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/PBFeeols+c85jnR06x9ywIT68p5aRlXBOjwWA1+V4=;
 b=WB9d/TYBASJtDYBaymduVORNTOVDzXdVtN8Rhqp4q8H/A2jxMtVrrtCR/aE1K3qXpdBC/HK2U+Ru6p04bm60JwKkJcH1Qk8fiIMAS40KLr0l51NWTtZDqEnT5jcW1wB8LngTi8OoNdmPARHnBiyjgT7egBWsWBGIzUR6QSq+1uSEd51vzWnKSavWIgdPZzv+2ASI0y0WVfggWZe8hP/kxGtTtclmGb4a9ov1sT9+Yz4PiwY0MqQxSD8BJ80OATyayDoPkUOF1drAMkCzSd87UawNUYF7dHTzydJu3kJMbHEW+BMfOU1L+NfrEkTv+l1mEPOsu74vPZKTZVWMXtT2qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6527.namprd11.prod.outlook.com (2603:10b6:8:8e::19) by
 DM4PR11MB7351.namprd11.prod.outlook.com (2603:10b6:8:104::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.16; Mon, 16 Mar 2026 04:05:23 +0000
Received: from DM4PR11MB6527.namprd11.prod.outlook.com
 ([fe80::b36e:ab4:9ded:1305]) by DM4PR11MB6527.namprd11.prod.outlook.com
 ([fe80::b36e:ab4:9ded:1305%5]) with mapi id 15.20.9723.010; Mon, 16 Mar 2026
 04:05:23 +0000
Date: Sun, 15 Mar 2026 21:05:20 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: <phasta@kernel.org>
CC: Boris Brezillon <boris.brezillon@collabora.com>, Chia-I Wu
 <olvaffe@gmail.com>, ML dri-devel <dri-devel@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, Steven Price <steven.price@arm.com>, "Liviu
 Dudau" <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Danilo Krummrich <dakr@kernel.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, open list <linux-kernel@vger.kernel.org>,
 <tj@kernel.org>
Subject: Re: drm_sched run_job and scheduling latency
Message-ID: <abeBgAXU8eG8tddH@lstrano-desk.jf.intel.com>
References: <CAPaKu7RbCtkz1BbX57+CebB2uepyCAi-3QzBy8BDGngCJ-Du0w@mail.gmail.com>
 <aajkqXZDGUFPlq1o@lstrano-desk.jf.intel.com>
 <20260305092711.20069ca1@fedora>
 <fa4a9c55792b0e79d94faa82085b693aa7feb989.camel@mailbox.org>
 <aalIbgi71svPQs3Z@lstrano-desk.jf.intel.com>
 <9949a2c27b2a1dc1cde10dbb89edec53411614b1.camel@mailbox.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9949a2c27b2a1dc1cde10dbb89edec53411614b1.camel@mailbox.org>
X-ClientProxiedBy: MW4PR03CA0327.namprd03.prod.outlook.com
 (2603:10b6:303:dd::32) To DM4PR11MB6527.namprd11.prod.outlook.com
 (2603:10b6:8:8e::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6527:EE_|DM4PR11MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 649a43a1-c5fe-43e1-747e-08de83113f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: p6N5PIbrqvuHQyKdWUj7ekPmiyEdlj8AWRDvuMUl1xO4ustQUTe5tEWoeNqC+wc9FZntxrjxHrbaZ9laT++t0wK5dcECKRPFVafroJQ3vH0ucI8Two+9yKV8OgS3cikJz6DGRByNt8VXz2lkKKr/6C/kMfgIlsK9CZJ4JCpJmVpeFHgztUlcOsnOgBWqEkKsilM+vipblDsGMFEtZJ/xGDA7sIXw5bB8wn7+COTPwqMU2CRyJyQU3S4qvCLBzy/OOd+/wCEic59j7xUDmdudqkX5AmOyHhdaY9FG8wnwGGbKKqXbkcQ/YQkW/7MIEReohcnsSjFNic7HLe4MYPsTsqbW4SPqn7RTuuKQ9NRMlaxIRY7G0ND+RyiNFo4WCaxo+YLxwPulmc/6DwLW5+t8A5zZKH8jJ+Sn/jOC0Ff6g8b6b+rTbBkl+evRANpzYL9A7k64UNOqETT75QR8FcdriWeVaJx+CYKR8f00zmGsOCCEMgniai5Y0YaSfzdJ+VtzUNdww+7EI7lPELBtocV/STgeXEwjYrJpxqhxWQWgn7dR3sMiuGLD9FiR4An7aIoibEcWgAHVZpyrPx44KO2ZoGDTbpGKMkXtEmsrxESKnR43elJAquKgMd2FwMHBj8BBcN4Odhpo+tOx+/lgtCFj4AjGB6htsdwKRpLLo9cJ6ME9Q3jpUZYNU2FfPLoV2VAE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6527.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlpTd3o1ZDJPUTZPclpqZDFrMEtSWWxYZmFoMHJycVBjVDUxYm41OTJ5WGxX?=
 =?utf-8?B?M05zMkZkT3ZKUkI0clZEVjVWMGMxOWpTMk9Hd3p0SFBQRHkvdTJMUkhFZkpU?=
 =?utf-8?B?VkcxQ0NtS3AwM1NnVHdZaFJxS21OajIzZmRvTW1aUkNxZ2xuTCtVSEpPR0Ji?=
 =?utf-8?B?UEZxcGVWcXUvWlRIb0xESkdEKy83WE5PWWR2RFFQbWl3dWpFR2VXSlJOaEVi?=
 =?utf-8?B?N0NMTkdpeFFVSjV0aWpEa0kvZldUQzZaS1RRcXBKMnVBNzdQOVVSbExtODVS?=
 =?utf-8?B?VG81R3JXT0d6RTA5UmVsQS9DQWlzSkNxeFRNQ0pQdWYvaHRGUWxzbHJob2tl?=
 =?utf-8?B?VWIvekU4dXpDN21LTXlUL3VTVXFwcjMxc3pReW1icXFqYWN4b1QwdlVreERW?=
 =?utf-8?B?aE5YY3ZlNzdpQS8xbEQ2YWdjMmU5bVp0Rm5CZ2xsR1BRWTJxSTlhV2FpM2Jo?=
 =?utf-8?B?eXNuWDFLUUZLSlJXb05DSkhWM2ZzVW9XaUl6Nm0va2ZoYjRuOVpXbkRyeUpP?=
 =?utf-8?B?R2lnY1FUMkh6VlpUTzcyWGQ4N3VQMzZpTmFrR1BBVlN6VXl0VkNyN1V5YkQ2?=
 =?utf-8?B?aFh6OHluaWx1dWZDZEw5ZW8waTcyTlB5MGEvV0xEVGlWaE9YUFZZS0xlbDNi?=
 =?utf-8?B?QStjSFZ4MTNHRklwMDc3d3BRbTRiKzBGQTU3MjhwUWxjSHB2R1UwUXdKUUxX?=
 =?utf-8?B?NkdUQVRUZFJPQnNhY01ySVRSaUdTeGFieDBvVW5xUWdWS0FhcCtQbjFXSHRB?=
 =?utf-8?B?dEVZSmhmK1F3d1ZNSXYzeHBBa2U3SE5JenlWYWcwNWtNemFmSjI1bi9EVXNK?=
 =?utf-8?B?T3BLejZvQmRxd0F0ejdRSkhvUElFRTRwcEx5eXlsNUxSbzQ4REhzbTUwa09Q?=
 =?utf-8?B?S1d5R3N3LytQN1F4YjQzbFU4U0hXVFRxY0s3RVZpcEx0NmNZaWE3M0RTb09s?=
 =?utf-8?B?M1E3TWhHQnFKcVJBZmdWbXpzVkZqTi83RVJQcjRGaWFhaFZjUEpyS2pUMmdT?=
 =?utf-8?B?a0Z5dUUzRHhPVU81RGJyYlBqakRyVk1SMUVjeWNDT2FkZnc4L3QrejlqdzJ0?=
 =?utf-8?B?TmdHMW5WTC83ODM3Y085U0ZDTmZsTGJWbFRRS1JQVkhSZXMwS2xBSnFJeHZz?=
 =?utf-8?B?UFFIUUY4WlFPekVMVjhCZllCc3ZKbDJmS3NOOEIzdmF6YTJhbFNoTWI4RnhC?=
 =?utf-8?B?V0NJMzBnak5ySGxtdWJvTUdrTmovODk4VkhsQ0s0U2Rkcm9ETGpFWW5SclBi?=
 =?utf-8?B?a2M0ZjB6NUFkM3F1VEpxQzliaGp5eTdXdEhTNTVqSFFhczBMT2pHeWkyWG9W?=
 =?utf-8?B?TmNnZjl6a3FuTi9adVkva0QzQ0lQeWhydEw2MFFleE92T2Q2VW5rYzdXOFg2?=
 =?utf-8?B?MDBwSFdqTDZNdUVVZzh6VG1xblhqdm5rLzdWK2lpVFI4NXpjNDRGRkVxRHd4?=
 =?utf-8?B?eDI4VFkySzE4U3BlV1RyM3k5aTAyVUU3SmppUEJUcGFMVklrYURwbThucmVD?=
 =?utf-8?B?c3BCa09zay82eVlJTnh5WUlUTFhVWU5SZ2lreGVYUnh1aVhGQysrUzcwckVK?=
 =?utf-8?B?ejRPN1A1OEYvWThzbGYrTnJpemVES09lY1dCaXZmRDhPdUo4WXNGdVVzZnZW?=
 =?utf-8?B?Z2gzL2pwdHAvWEIvN3Ayb2ZodGI1RDlmbC9oZmVlcHRiUUE5VDdCcW1XYVdN?=
 =?utf-8?B?WFMvTExudHl5a0xjV1VYa3A1Q0kxQWtHckRVMDZlTUFjNzZENUNiVnNCWWt0?=
 =?utf-8?B?ZDkzMmJpSHlvdm9YVUhBMjdRZ0FiR3lIL2dBM1hQQVN1V0E1eG0yT0lWVWtO?=
 =?utf-8?B?YkxhRmVoRXpIQmxOdTlqc0xqWVQ5aCtFa0FBRDJHMkhnSGhURlBjSm9nb29m?=
 =?utf-8?B?ZTBHTitlYmJ3SjlPb04xTlZ2M1RwbWk3MG5TenVTdG95TEtveUxGUHhrTzFo?=
 =?utf-8?B?eU8zWWI4bDZoLzNmRXdpcHBqR2VEd1Y5OVcwTXhueDdvQWVFbE1FQ21vLzBS?=
 =?utf-8?B?Y0crREVrMDJTQys4dzJUQ29xV1E1ZUFzTzZvelh4ZnhUTktXOVpWVjRHWjlZ?=
 =?utf-8?B?NVFlVklhSHcyYXZzU3RTelRrQlE3ZW04OXVjWkZJZm9UcjgycWs1TVJDMzhT?=
 =?utf-8?B?SzdxVENXNEhqbVpEZDNUcWpSdFRhcnJrRVhYbHBWb3UyNnlVTE04MlZjakp0?=
 =?utf-8?B?Yk9YOWVGRERFaUwxdWtRcE9mMzYzc1I5Z1FpcWFvMDRpb3RhZUdreExSajRt?=
 =?utf-8?B?a2JPdDc3Rlc2VTYyZXQzQ0Q2NlVna3I0bjRocmU4Q2VGY2lBdmg5SkZxWVFN?=
 =?utf-8?B?bWxxbkN6Y2tibjFLZURHdHRVSFhJTUdIUnQ3Y3hsM2J0N1dKYVVIaFhvK2wx?=
 =?utf-8?Q?rP7/wpNnRDeus0Ow=3D?=
X-Exchange-RoutingPolicyChecked: SB4KPQ7pwgkXnAlhjLU+aiJggNSB6JIAXzfg7ksjeZk7SRKOIpFNQTYoD/yskJpWeXmU4SMT4HeB7xGI1VK2Cly7dG35mY4ycZyRSstdLCsNxc9uDImXoSwyZcBNfa/NomXRP52mITQlI0a0eurKqOdRNLfLUjFUImTQcsJnFN6S83pLTaX5+4SbqBl93QjC6fEcKKKnK5wCvvUjaR9ggExLUDaTwSZuJYYCtk9s0AcUFNP3oWm7nA16kVbQ3+3zHqVgrY99ATcVTmYtOb94bQ8aLEYAhZ54rkhm6Orw6RgDJh+mVF319NKDmX25s+oHUZQsEmWyvqw14KgaC7KiOA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 649a43a1-c5fe-43e1-747e-08de83113f5b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 04:05:23.6110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwsA0J/LmiawS2RV0PKqtwbLK6qUKZpcfqQS9VU78jR/ytfH/+CC7DhPEHm6dAb4dpch62Hpi/yxPTk0n5LWtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7351
X-OriginatorOrg: intel.com
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

On Thu, Mar 05, 2026 at 10:47:32AM +0100, Philipp Stanner wrote:

Off the list... I don’t think airing our personal attacks publicly is a
good look. I’m going to be blunt here in an effort to help you.

> On Thu, 2026-03-05 at 01:10 -0800, Matthew Brost wrote:
> > On Thu, Mar 05, 2026 at 09:38:16AM +0100, Philipp Stanner wrote:
> > > On Thu, 2026-03-05 at 09:27 +0100, Boris Brezillon wrote:
> > > 
> > > > 
> 
> […]
> 
> > > > Honestly, I'm not thrilled by this fast-path/call-run_job-directly idea
> > > > you're describing. There's just so many things we can forget that would
> > > > lead to races/ordering issues that will end up being hard to trigger and
> > > > debug.
> > > > 
> > > 
> > > +1
> > > 
> > > I'm not thrilled either. More like the opposite of thrilled actually.
> > > 
> > > Even if we could get that to work. This is more of a maintainability
> > > issue.
> > > 
> > > The scheduler is full of insane performance hacks for this or that
> > > driver. Lockless accesses, a special lockless queue only used by that
> > > one party in the kernel (a lockless queue which is nowadays, after N
> > > reworks, being used with a lock. Ah well).
> > > 
> > 
> > This is not relevant to this discussion—see below. In general, I agree
> > that the lockless tricks in the scheduler are not great, nor is the fact
> > that the scheduler became a dumping ground for driver-specific features.
> > But again, that is not what we’re talking about here—see below.
> > 
> > > In the past discussions Danilo and I made it clear that more major
> > > features in _new_ patch series aimed at getting merged into drm/sched
> > > must be preceded by cleanup work to address some of the scheduler's
> > > major problems.
> > 
> > Ah, we've moved to dictatorship quickly. Noted.
> 
> I prefer the term "benevolent presidency" /s
> 
> Or even better: s/dictatorship/accountability enforcement.
> 

It’s very hard to take this seriously when I reply to threads saying
something breaks dma-fence rules and the response is, “what are
dma-fence rules?” Or I read through the jobqueue thread and see you
asking why a dma-fence would come from anywhere other than your own
driver — that’s the entire point of dma-fence; it’s a cross-driver
contract. I could go on, but I’d encourage you to take a hard look at
your understanding of DRM, and whether your responses — to me and to
others — are backed by the necessary technical knowledge.

Even better — what first annoyed me was your XDC presentation. You gave
an example of my driver modifying the pending list without a lock while
scheduling was stopped, and claimed you fixed a bug. That was not a bug
- Xe would explode if it was as we test our code. The pending list can
be modified without a lock if scheduling is stopped. I almost grabbed
the mic to correct you. Yes, it’s a layering violation, but presenting
it aa a bug shows a clear lack of understanding.

> How does it come that everyone is here and ready so quickly when it

I’ve suggested ideas to fix DRM sched (refcounting, clear teardown
flows), but they were immediately met with resistance — typically from
Christian with you agreeing. My willingness to fight with Christian is
low; I really don’t need another person to argue with.

> comes to new use cases and features, yet I never saw anyone except for
> Tvrtko and Maíra investing even 15 minutes to write a simple patch to
> address some of the *various* significant issues in that code base?
> 
> You were on CC on all discussions we've had here for the last years
> afair, but I rarely saw you participate. And you know what it's like:

I’ll admit I’m busy with many other things, so my bandwidth is limited.
But again, if I chime in and explain how I solved something in Xe (e.g.,
refcounting) and it’s met with resistance, I’ll likely move on — I’ve
already solved it, and I’ll just let you fail (see cancel_job).

> who doesn't speak up silently agrees in open source.
> 
> But tell me one thing, if you can be so kind:
> 

I'm glad you asked this, and it inspired me to fix this, more below [1].

> What is your theory why drm/sched came to be in such horrible shape?

drm/sched was ported from AMDGPU into common code. It carried many
AMDGPU-specific hacks, had no object-lifetime model thought out as a
common component, and included teardown nightmares that “worked,” but
other drivers immediately had to work around. With Christian involved —
who is notoriously hostile — everyone did their best to paper over
issues driver-side rather than get into fights and fix things properly.
Asahi Linux publicly aired grievances about this situation years ago.

> What circumstances, what human behavioral patterns have caused this?
> 

See above.

> The DRM subsystem has a bad reputation regarding stability among Linux
> users, as far as I have sensed. How can we do better?
> 

Write sane code and test it. fwiw, Google shared a doc with me
indicating that Xe has unprecedented stability, and to be honest, when I
first wrote Xe I barely knew what I was doing — but I did know how to
test. I’ve since cleaned up most of my mistakes though.

So how can we do better... We can [1].

I started on [1] after you asking what the problems in DRM sched - which
got me thinking about what it would look like if we took the good parts
(stop/start control plane, dependency tracking, ordering, finished
fences, etc.), dropped the bad parts (no object-lifetime model, no
refcounting, overly complex queue teardown, messy fence manipulation,
hardware-scheduling baggage, lack of annotations, etc.), and wrote
something that addresses all of these problems from the start
specifically for firmware-scheduling models.

It turns out pretty good.

Main patch [2].

Xe is fully converted, tested, and working. AMDXNDA and Panthor are
compiling. Nouveau and PVR seem like good candidates to convert as well.
Rust bindings are also possible given the clear object model with
refcounting and well-defined object lifetimes.

Thinking further, hardware schedulers should be able to be implemented
on top of this by embedding the objects in [2] and layering a
backend/API on top.

Let me know if you have any feedback (off-list) before I share this
publicly. So far, Dave, Sima, Danilo, and the other Xe maintainers have
been looped in.

Matt

[1] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/tree/local_dev/new_scheduler.post?ref_type=heads
[2] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/0538a3bc2a3b562dc0427a5922958189e0be8271

> > 
> > > 
> > 
> > I can't say I agree with either of you here.
> > 
> > In about an hour, I seemingly have a bypass path working in DRM sched +
> > Xe, and my diff is:
> > 
> > 108 insertions(+), 31 deletions(-)
> 
> LOC is a bad metric for complexity.
> 
> > 
> > About 40 lines of the insertions are kernel-doc, so I'm not buying that
> > this is a maintenance issue or a major feature - it is literally a
> > single new function.
> > 
> > I understand a bypass path can create issues—for example, on certain
> > queues in Xe I definitely can't use the bypass path, so Xe simply
> > wouldn’t use it in those cases. This is the driver's choice to use or
> > not. If a driver doesn't know how to use the scheduler, well, that’s on
> > the driver. Providing a simple, documented function as a fast path
> > really isn't some crazy idea.
> 
> We're effectively talking about a deviation from the default submission
> mechanism, and all that seems to be desired for a luxury feature.
> 
> Then you end up with two submission mechanisms, whose correctness in
> the future relies on someone remembering what the background was, why
> it was added, and what the rules are..
> 
> The current scheduler rules are / were often not even documented, and
> sometimes even Christian took a few weeks to remember again why
> something had been added – and whether it can now be removed again or
> not.
> 
> > 
> > The alternative—asking for RT workqueues or changing the design to use
> > kthread_worker—actually is.
> > 
> > > That's especially true if it's features aimed at performance buffs.
> > > 
> > 
> > With the above mindset, I'm actually very confused why this series [1]
> > would even be considered as this order of magnitude greater in
> > complexity than my suggestion here.
> > 
> > Matt
> > 
> > [1] https://patchwork.freedesktop.org/series/159025/ 
> 
> The discussions about Tvrtko's CFS series were precisely the point
> where Danilo brought up that after this can be merged, future rework of
> the scheduler must focus on addressing some of the pending fundamental
> issues.
> 
> The background is that Tvrtko has worked on that series already for
> well over a year, it actually simplifies some things in the sense of
> removing unused code (obviously it's a complex series, no argument
> about that), and we agreed on XDC that this can be merged. So this is a
> question of fairness to the contributor.
> 
> But at one point you have to finally draw a line. No one will ever
> address major scheduler issues unless we demand it. Even very
> experienced devs usually prefer to hack around the central design
> issues in their drivers instead of fixing the shared infrastructure.
> 
> 
> P.

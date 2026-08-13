Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050A9C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 21:02:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DD8E10F52D;
	Thu, 13 Aug 2026 21:02:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CKh4eK9K";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010049.outbound.protection.outlook.com
 [52.101.193.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE11910F530
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 21:02:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZJ9x6+gf27kcKzcTLA4SCQBBOG3m82g9P4SXBNpLzjh4vqZU24zLRGC5106T5I9xRwPXGblQNYCDo81cHvpvchOEqgJi2+A+gvnX/1V/Uwh96Cu2Nn3rOfD1pdQvSpkKL1tTd48jrVrrU4fTE/8JAo59/mujpZecmtCx7tT8I6S8AQi1WZZmMpNSByD+TK39CfHwCzBVLAvjyUliDiltlvVH5vbVsHLvGgk6qBUzAN9noWLMwZDevoQ7m9vfBLZsYWBo0+Q/DxNYacRO4k6NtB2RKmheEBxGRHzULXqCMiX3RJ4MNXmJETH82xaZzHfDLkYkcqPOt5nohvymcvbHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVnqbBE4wqikU6PFQ9OmS9gRKQjh/RFYL6OHqRlb+rg=;
 b=LNZtYpDAa3w9SuBLyHGlA1KjXUWz1YVOvhnY63iBQLnQpf9mvGhKwXZhoowus3YttFppje8N2VuOQZ7y08utz+Wcqwxt+sEz2t2dpduwrLbhtcwdQsnh2YG11rvSyiy9ZGM5Ip37EoyMpxi4cOq9cabWTJVMvTvarbajeys2DHmoEWFxb6iESW+SfHksXVCf/e4yNG7I9IMxgdETKFklL9oIDXKFRaV1pAyl/34QOkVDlQsWRd7HnpAAxW40iuarX8P1dClBeLbviJG1E/OiJeaGGeM9N1+s3N0BEjTefUNw+BeJOVVbQqMLyVB6blYS7gXWaQN0OLucFLWMMjJ8FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVnqbBE4wqikU6PFQ9OmS9gRKQjh/RFYL6OHqRlb+rg=;
 b=CKh4eK9KH/vIceArcJgAhdTSYcSpmQndZ3TVpMNU/4NAkvtDedkWNZHcZMotYhSPaIBxHkC3KUvmzRnhLv4ZLPop345OChCqNTZZiLynEICY6QcxwDsemmqIEeXqW/aVWrtkOUP1yZQLKSEDw3E6WmjDI+dfu1PYC371dNwyKHU=
Received: from DS7P220CA0044.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::30) by
 BL1PR12MB5994.namprd12.prod.outlook.com (2603:10b6:208:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Thu, 13 Aug
 2026 21:02:29 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:8:224:cafe::18) by DS7P220CA0044.outlook.office365.com
 (2603:10b6:8:224::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 21:02:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 21:02:28 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 16:02:28 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 13 Aug 2026 16:02:27 -0500
Message-ID: <9e7444c7-7a2a-5946-6197-86676de0cbb2@amd.com>
Date: Thu, 13 Aug 2026 14:02:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/5] accel/amdxdna: honour the SYNC_BO range
Content-Language: en-US
To: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>, Alex Deucher
 <alexdeucher@gmail.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>
CC: Min Ma <mamin506@gmail.com>, Oded Gabbay <ogabbay@kernel.org>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>
References: <20260811231351.1011244-1-taimuraz@kaitmazov.com>
 <a505f9e5-b416-43e9-934d-c5c29b8a70e9@amd.com>
 <9420bbe5-46a3-84be-eae8-596bc42bddac@amd.com>
 <CADnq5_OR5bFoFJoMoj9bc2_f47TunVnDFrmA_2tT+0k-DZk_jw@mail.gmail.com>
 <20260813195059.149991-1-taimuraz@kaitmazov.com>
 <CADnq5_PZxoBKqsg6i0eN-wkOBF3UrEZ2cVkMAtgzVD7Kv6ZSDA@mail.gmail.com>
 <20260813201416.158728-1-taimuraz@kaitmazov.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260813201416.158728-1-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|BL1PR12MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: d0539f4d-e167-46b3-325f-08def97e2ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|5023799004|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PHWo+7DAqi0uccHU3XGrXr1sbh2AASG5omKTq0U2NXWdLQSXktKFj4r2F8ixj0iBpJOR8IgeA0cl6NTTAr6irczwhjHF3AZjNxgihn66cHK8EKqesaeUjBqyq4b+DPhQTTSl1JyZguGJswrtfiblXzPdzbeG5BMYF3wcnzs+yiJBWmwa2uzOBnxkmw6/X5Uyz0f/nnRE0UPKFz/PZEjW/uF6Hf/d0qm0I0iUfErWYXoSy/+O2NEtJIcHsjDfbrmigkKvYyl//9gbkwqkCJ8KHOSqqouYdZjPHDneD/ObM/OJCzmq1WEg3Yewb6zfq5cEpF14T41uVvpzoLwqYJPziABtF4I4rMmdO3jXgYDHTmyEToaCpByW+La++v1QWd40UpkTN3WMHorj2l2dYvjX8+Nhq5AIFrrC5Vhk76jRy1Eqc2TCrCCgk57zwg5Nw5YUnkfQWuU7GlECD6OjxgLehLNlWyYmyMLmHpOTbw0M8gW5xxs8ZKWt9FjNtcZKweDmyo92ixt9OkLTvlQFt6YgWnTBvn7OQTOZp1GawY49g/3dWtN1njVORu/0bUTIJ3vL3c6Xtp3Jz/OeiezwOw3ktXrsu2zNHpHr+ZWzK/q8/+F6xKsEczfsbUSjasLMDoYrB2q7nCB5aUkUz2z8VrSR3QySTeNUUeZLKxzC3+45cqPi3cpEXB4bBqmCbKPDtcUZyyis127k4PmiR199llod8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(5023799004)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yOOdfDR7BYJhSxZuZsUJJK0toZZVTaRq6thU+szkA4RGMuKBIa8F/ohdzbLiT7sGZ4L1m6Lpb+DoP8RO653sVCiEfp/17Ni0b2DZWIxXrMiZF62pX5wdIySB7dFuYUSL0lDs6Z427alVtml3HgVZmfklrLwiTEpasxmpCv8Pdy/BLqN2H/hLUv2a9Vmkq/mOLDfL06uTlmygjZG3EZiSjDNuU9E39jIIcdJ94FPKl61nYBF8oHMmnm9bqa6zytbKhDFCbrTtkVMVY6JcVQElGZhW46ti481hBsKU5KVmoHSVJnDbADtvSae0qr/XmNgjcb1kLi9C6ZPGmKT9CVgCQ2vC5rx3oiPJn1LAtgKvM46nl87JYYivLmlIDqlBWjgXKwb8M95yGfaQ0bEhzng18NE3e1sTT/cRpoZgviN7gCW1PoAccfriyx5Y2trjM6Lm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 21:02:28.2028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0539f4d-e167-46b3-325f-08def97e2ef9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5994
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


On 8/13/26 13:14, Taimuraz Kaitmazov wrote:
> On 8/13/26 23:06, Alex Deucher wrote:
>> I wonder if there is some device config option to enable snooped vs.
>> non-snooped DMAs?
> I tried the PCIe one. Clearing Enable No Snoop in DevCtl, with lspci then showing NoSnoop-, changes nothing: same 20 out of 20 stale both ways. So the array either isn't carrying the attribute or isn't looking at it.

Yes. It is known that the legacy hardware has problem to support snoop. 
In your case, the XRT's buffer::sync() could be used.

Lizhi

>
> Taimuraz
>
>
